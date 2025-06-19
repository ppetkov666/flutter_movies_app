import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/domain/repositories/movie_repository_impl.dart';
import 'package:movies_app/presentation/movies/widgets/movies_list_view.dart';
import 'package:movies_app/presentation/components/movie_loading_view.dart';
import 'package:movies_app/presentation/components/movie_error_view.dart';
import 'package:movies_app/presentation/components/movie_empty_view.dart';
import 'package:movies_app/presentation/movies/view_model/movies_view_model.dart';
import 'package:movies_app/presentation/components/movie_app_bar.dart';
import 'package:movies_app/presentation/components/movie_app_bar_icon_button.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/routes/app_routes.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late final MoviesViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MoviesViewModel(
      MovieRepositoryImpl(apiService: MovieApiService()),
    );
    _viewModel.fetchMovies();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Scaffold(
        appBar: MovieAppBar(
          title: const Text(UIStrings.comingSoonTitle),
          actions: [
            MovieAppBarIconButton(
              icon: Icons.person,
              tooltip: UIStrings.profileTooltip,
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .pushNamed(AppRoutes.profile);
              },
            ),
            MovieAppBarIconButton(
              icon: Icons.bookmark,
              tooltip: UIStrings.watchListTooltip,
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .pushNamed(AppRoutes.watchList);
              },
            ),
            MovieAppBarIconButton(
              icon: Icons.logout,
              tooltip: UIStrings.logoutTooltip,
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        ),
        body: Consumer<MoviesViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) return const MovieLoadingView();
            if (viewModel.error != null) {
              return MovieErrorView(viewModel.error!);
            }
            if (viewModel.movies.isEmpty) {
              return const MovieEmptyView(UIStrings.noResultsAvailable);
            }
            return MoviesListView(movies: viewModel.movies);
          },
        ),
      ),
    );
  }
}
