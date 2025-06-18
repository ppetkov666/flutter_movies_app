import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/presentation/movies/view_model/movies_view_model.dart';
import 'package:movies_app/domain/repositories/movie_repository_impl.dart';
import 'package:movies_app/presentation/movies/widgets/movies_list_view.dart';
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
        appBar: AppBar(
          title: const Text('Coming Soon'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Profile',
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .pushNamed(AppRoutes.profile);
              },
            ),
            IconButton(
              icon: const Icon(Icons.bookmark),
              tooltip: 'Watch List',
              onPressed: () {
                Provider.of<NavigatorProvider>(context, listen: false)
                    .pushNamed(AppRoutes.watchList);
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
            ),
          ],
        ),
        body: Consumer<MoviesViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(child: Text(viewModel.error!));
            }

            return MoviesListView(movies: viewModel.movies);
          },
        ),
      ),
    );
  }
}
