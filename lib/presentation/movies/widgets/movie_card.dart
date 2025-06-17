import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/routes/app_routes.dart'; // ✅ Add this import

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 70,
          child: hasValidImage
              ? CachedNetworkImage(
            imageUrl: movie.posterUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (_, __, ___) => _fallbackImage(),
          )
              : _fallbackImage(),
        ),
        title: Text(movie.title),
        subtitle: Text('IMDb: ${movie.imdbRating}'),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.movieDetails,
            arguments: {
              'movie': movie,
              'hasValidImage': hasValidImage,
            },
          );
        },
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: Colors.grey.shade200,
      alignment: Alignment.center,
      child: const Text(
        'No image',
        style: TextStyle(fontSize: 12, color: Colors.black45),
        textAlign: TextAlign.center,
      ),
    );
  }
}
