import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/movies/view/movie_details_screen.dart';
import 'package:movies_app/presentation/movies/view/movie_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String movieDetails = '/movie-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MoviesScreen());

      case movieDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final movie = args['movie'] as Movie;
        final hasValidImage = args['hasValidImage'] as bool;

        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
            movie: movie,
            hasValidImage: hasValidImage,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('404')),
            body: const Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
