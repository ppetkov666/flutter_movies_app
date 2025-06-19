import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_app/presentation/shared/fallback_image.dart';

class MoviePoster extends StatelessWidget {
  final bool hasValidImage;
  final String posterUrl;

  const MoviePoster({
    super.key,
    required this.hasValidImage,
    required this.posterUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 60,
        height: 90,
        child: hasValidImage
            ? CachedNetworkImage(
                imageUrl: posterUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (_, __, ___) => const FallbackImage(),
              )
            : const FallbackImage(),
      ),
    );
  }
}
