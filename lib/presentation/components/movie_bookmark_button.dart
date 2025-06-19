import 'package:flutter/material.dart';

class MovieBookmarkButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onToggle;
  final Color? activeColor;
  final Color? inactiveColor;
  final double iconSize;
  final EdgeInsetsGeometry? padding;

  const MovieBookmarkButton({
    super.key,
    required this.isSaved,
    required this.onToggle,
    this.activeColor,
    this.inactiveColor,
    this.iconSize = 24.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      padding: padding ?? const EdgeInsets.all(8),
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved
            ? (activeColor ?? Colors.deepPurple)
            : (inactiveColor ?? Colors.grey),
      ),
      onPressed: onToggle,
    );
  }
}
