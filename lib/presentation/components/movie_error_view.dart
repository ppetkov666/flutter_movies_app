import 'package:flutter/material.dart';

class MovieErrorView extends StatelessWidget {
  final String message;
  final Color? color;
  final TextAlign textAlign;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;

  const MovieErrorView(
      this.message, {
        super.key,
        this.color,
        this.textAlign = TextAlign.center,
        this.padding = const EdgeInsets.all(16),
        this.style,
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
                color: color ?? Colors.red,
              ),
        ),
      ),
    );
  }
}
