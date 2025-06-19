import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/routes/app_routes.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:movies_app/presentation/components/movie_bookmark_button.dart';
import 'package:movies_app/presentation/components/movie_details_text.dart';
import 'package:movies_app/presentation/components/movie_poster.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool hasValidImage;

  const MovieCard({
    super.key,
    required this.movie,
    required this.hasValidImage,
  });

  @override
  Widget build(BuildContext context) {
    final navigatorProvider =
        Provider.of<NavigatorProvider>(context, listen: false);
    final watchListViewModel = Provider.of<WatchListViewModel>(context);
    final isSaved = watchListViewModel.isSaved(movie);

    final displayRating =
        movie.imdbRating.isNotEmpty && movie.imdbRating != 'N/A'
            ? movie.imdbRating
            : movie.ratings.isNotEmpty
                ? movie.averageRatingDisplay
                : 'N/A';

    return InkWell(
      onTap: () {
        navigatorProvider.pushNamed(
          AppRoutes.movieDetails,
          arguments: {
            'movie': movie,
            'hasValidImage': hasValidImage,
          },
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MoviePoster(
                  hasValidImage: hasValidImage, posterUrl: movie.posterUrl),
              const SizedBox(width: 16),
              Expanded(
                child: MovieDetailsText(
                  title: movie.title,
                  rating: displayRating,
                ),
              ),
              MovieBookmarkButton(
                isSaved: isSaved,
                onToggle: () => watchListViewModel.toggleMovie(movie),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
