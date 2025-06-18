import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:movies_app/presentation/movies/widgets/movie_card.dart';
import 'package:movies_app/domain/entities/movie.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchList = context.watch<WatchListViewModel>().savedMovies;

    return Scaffold(
      appBar: AppBar(title: const Text('My watch list')),
      body: watchList.isEmpty
          ? const Center(child: Text('No saved movies yet.'))
          : ListView.builder(
              itemCount: watchList.length,
              itemBuilder: (context, index) {
                final Movie movie = watchList[index];
                return MovieCard(
                  movie: movie,
                  hasValidImage: movie.hasValidImage,
                );
              },
            ),
    );
  }
}
