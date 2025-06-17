import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';

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
                errorWidget: (_, __, ___) => _fallbackImage(),
              )
                  : _fallbackImage(),
            ),
            const SizedBox(height: 16),
            Text(
              'IMDb Rating: ${movie.imdbRating}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text('Release Date: ${movie.releaseDate}'),
            const SizedBox(height: 8),
            Text('Duration: ${movie.duration}'),
            const SizedBox(height: 8),
            Text('Rating: ${movie.contentRating}'),
            const SizedBox(height: 8),
            Text('Average Rating: ${movie.averageRating}'),
            const SizedBox(height: 16),

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
            ]
          ],
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Text(
        'No image available',
        style: TextStyle(fontSize: 14, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
    );
  }
}
