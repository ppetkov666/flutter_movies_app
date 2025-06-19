import 'package:flutter/material.dart';

class MovieEmptyView extends StatelessWidget {
  final String message;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;
  final Color? color;

  const MovieEmptyView(
      this.message, {
        super.key,
        this.textAlign = TextAlign.center,
        this.padding = const EdgeInsets.all(16),
        this.style,
        this.color,
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Text(
          message,
          textAlign: textAlign,
          style: style ??
              Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: color,
              ),
        ),
      ),
    );
  }
}
