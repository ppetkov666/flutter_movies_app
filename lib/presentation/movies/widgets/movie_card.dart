import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/routes/app_routes.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:movies_app/presentation/shared/fallback_image.dart';

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
                ? movie.averageRating
                : 'N/A';

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
                  placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  errorWidget: (_, __, ___) => const FallbackImage(),
                )
              : const FallbackImage(),
        ),
        title: Text(movie.title),
        subtitle: Text('Rating: $displayRating'),
        trailing: IconButton(
          icon: Icon(
            isSaved ? Icons.bookmark : Icons.bookmark_border,
            color: isSaved ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            watchListViewModel.toggleMovie(movie);
          },
        ),
        onTap: () {
          navigatorProvider.pushNamed(
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
}
