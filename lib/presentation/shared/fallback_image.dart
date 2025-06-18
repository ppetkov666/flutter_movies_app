import 'package:flutter/material.dart';

class FallbackImage extends StatelessWidget {
  final String message;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;

  const FallbackImage({
    super.key,
    this.message = 'No image',
    this.fontSize = 12,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.textColor = Colors.black45,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(fontSize: fontSize, color: textColor),
        textAlign: TextAlign.center,
      ),
    );
  }
}
