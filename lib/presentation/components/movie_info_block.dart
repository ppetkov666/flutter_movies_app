import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'movie_info_text.dart';

class MovieInfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const MovieInfoBlock({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieInfoText(text: '$label: $value'),
        const Divider(height: 16),
      ],
    );
  }
}
