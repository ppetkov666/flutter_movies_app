import 'package:flutter/material.dart';

class MovieAppBarIconButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final Color color;

  const MovieAppBarIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: color,
      onPressed: onPressed,
    );
  }
}
