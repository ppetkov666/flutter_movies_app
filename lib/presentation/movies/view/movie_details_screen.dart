import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/presentation/shared/fallback_image.dart';
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
              child: hasValidImage
                  ? CachedNetworkImage(
                imageUrl: movie.posterUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const FallbackImage(),
              )
                  : const FallbackImage(),
            ),
            const SizedBox(height: 16),
            Text(
              movie.originalTitle.isNotEmpty
                  ? 'Original Title: ${movie.originalTitle}'
                  : movie.title,
              style: movie.originalTitle.isNotEmpty
                  ? Theme.of(context).textTheme.bodyLarge
                  : Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text('Release Year: ${movie.year}'),
            const SizedBox(height: 8),
            Text('Release Date: ${movie.releaseDate}'),
            const SizedBox(height: 8),
            Text('Duration: ${movie.formattedDuration}'),
            const SizedBox(height: 8),
            Text('Content Rating: ${movie.contentRating}'),
            const SizedBox(height: 8),
            Text('Average Rating: ${movie.averageRating}'),
            const SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {
                watchListViewModel.toggleMovie(movie);
              },
              icon: Icon(isSaved ? Icons.check : Icons.bookmark_border),
              label: Text(isSaved ? 'Saved to Watch List' : 'Add to Watch List'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSaved ? Colors.green : null,
              ),
            ),

            const SizedBox(height: 24),
            if (movie.genres.isNotEmpty) ...[
              const Text(
                'Genres:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: movie.genres
                    .map((genre) => Chip(label: Text(genre)))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'Storyline:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              movie.storyline.isNotEmpty
                  ? movie.storyline
                  : 'No storyline available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (movie.actors.isNotEmpty) ...[
              const Text(
                'Actors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: movie.actors
                    .map((actor) => Chip(label: Text(actor)))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
