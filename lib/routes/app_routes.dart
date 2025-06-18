import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/movies/view/movie_details_screen.dart';
import 'package:movies_app/presentation/movies/view/movie_screen.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/presentation/watch_list/view/watch_list_screen.dart';
import 'package:movies_app/presentation/profile/view/profile_screen.dart';
import 'package:movies_app/presentation/profile/view_model/profile_view_model.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';

class AppRoutes {
  static const String home = '/';
  static const String movieDetails = '/movie-details';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String watchList = '/watch-list';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const MoviesScreen());

      case profile:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => ProfileViewModel(
              authProvider: Provider.of<AuthProvider>(context, listen: false),
              watchListViewModel: Provider.of<WatchListViewModel>(context, listen: false),
            ),
            child: const ProfileScreen(),
          ),
        );

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

      case watchList:
        return MaterialPageRoute(builder: (_) => const WatchListScreen());

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
