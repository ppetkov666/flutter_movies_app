import 'package:flutter/material.dart';

class MovieLoadingView extends StatelessWidget {
  final Color? color;
  final double? size;
  final double strokeWidth;
  final Alignment alignment;

  const MovieLoadingView({
    super.key,
    this.color,
    this.size,
    this.strokeWidth = 4.0,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final loader = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );

    return Align(
      alignment: alignment,
      child: loader,
    );
  }
}
