import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/presentation/movies/view_model/movies_view_model.dart';
import 'package:movies_app/domain/repositories/movie_repository_impl.dart';
import 'package:movies_app/presentation/movies/widgets/movies_list_view.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoviesViewModel(
        MovieRepositoryImpl(apiService: MovieApiService()),
      )..fetchMovies(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Coming Soon')),
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
