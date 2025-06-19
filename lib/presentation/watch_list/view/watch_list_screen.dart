import 'package:flutter/material.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:movies_app/presentation/movies/widgets/movie_card.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/components/movie_empty_view.dart';

class WatchListScreen extends StatelessWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watchList = context.watch<WatchListViewModel>().savedMovies;

    return Scaffold(
      appBar: AppBar(title: const Text(UIStrings.watchListLabel)),
      body: watchList.isEmpty
          ? const MovieEmptyView(UIStrings.noSavedMoviesLabel)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: watchList.length,
                itemBuilder: (context, index) {
                  final Movie movie = watchList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MovieCard(
                      movie: movie,
                      hasValidImage: movie.hasValidImage,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
