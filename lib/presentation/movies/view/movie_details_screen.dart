import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/constants/ui_strings.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/components/movie_poster.dart';
import 'package:movies_app/presentation/components/movie_bookmark_action_button.dart';
import 'package:movies_app/presentation/components/movie_section_block.dart';
import 'package:movies_app/presentation/components/movie_info_block.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final bool hasValidImage;

  const MovieDetailsScreen({
    super.key,
    required this.movie,
    required this.hasValidImage,
  });

  @override
  Widget build(BuildContext context) {
    final watchListViewModel = Provider.of<WatchListViewModel>(context);
    final isSaved = watchListViewModel.isSaved(movie);

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2 / 3,
              child: MoviePoster(
                hasValidImage: hasValidImage,
                posterUrl: movie.posterUrl,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.originalTitle.isNotEmpty
                  ? '${UIStrings.originalTitleLabel}: ${movie.originalTitle}'
                  : movie.title,
              style: movie.originalTitle.isNotEmpty
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            if (movie.year.isNotEmpty)
              MovieInfoBlock(label: UIStrings.releaseYearLabel, value: movie.year),
            if (movie.releaseDate.isNotEmpty)
              MovieInfoBlock(label: UIStrings.releaseDateLabel, value: movie.releaseDate),
            if (movie.formattedDuration.isNotEmpty)
              MovieInfoBlock(label: UIStrings.durationLabel, value: movie.formattedDuration),
            if (movie.contentRating.isNotEmpty)
              MovieInfoBlock(label: UIStrings.contentRatingLabel, value: movie.contentRating),
            if (movie.averageRatingDisplay.isNotEmpty)
              MovieInfoBlock(label: UIStrings.averageRatingLabel, value: movie.averageRatingDisplay),
            const SizedBox(height: 16),
            MovieBookmarkActionButton(
              isSaved: isSaved,
              onToggle: () => watchListViewModel.toggleMovie(movie),
            ),
            const SizedBox(height: 24),
            if (movie.genres.isNotEmpty)
              MovieSectionBlock(
                title: UIStrings.genresLabel,
                children: movie.genres
                    .map((g) => Chip(
                  label: Text(g),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.1),
                ))
                    .toList(),
              ),
            MovieSectionBlock(
              title: UIStrings.storylineLabel,
              child: Text(
                movie.storyline.isNotEmpty
                    ? movie.storyline
                    : UIStrings.noStorylineAvailable,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            if (movie.actors.isNotEmpty)
              MovieSectionBlock(
                title: UIStrings.actorsLabel,
                children: movie.actors
                    .map((a) => Chip(
                  label: Text(a),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary
                      .withOpacity(0.1),
                ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
