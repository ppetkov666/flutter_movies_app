import 'package:flutter/material.dart';
import 'package:movies_app/constants/ui_strings.dart';

class MovieDetailsText extends StatelessWidget {
  final String title;
  final String rating;

  const MovieDetailsText({
    super.key,
    required this.title,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${UIStrings.ratingLabel}: $rating',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
