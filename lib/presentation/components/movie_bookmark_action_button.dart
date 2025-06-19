import 'package:flutter/material.dart';
import 'package:movies_app/constants/ui_strings.dart';

class MovieBookmarkActionButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onToggle;
  final Color? activeColor;
  final Color? inactiveColor;

  const MovieBookmarkActionButton({
    super.key,
    required this.isSaved,
    required this.onToggle,
    this.activeColor,
    this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onToggle,
      icon: Icon(isSaved ? Icons.check : Icons.bookmark_border),
      label: Text(
        isSaved ? UIStrings.savedToWatchList : UIStrings.addToWatchList,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSaved
            ? (activeColor ?? Colors.deepPurple)
            : (inactiveColor ?? Theme.of(context).colorScheme.primary),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
