import 'package:flutter/material.dart';

class MovieInfoText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry padding;

  const MovieInfoText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.padding = const EdgeInsets.only(bottom: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: style ?? Theme.of(context).textTheme.bodyMedium,
        textAlign: textAlign,
      ),
    );
  }
}
