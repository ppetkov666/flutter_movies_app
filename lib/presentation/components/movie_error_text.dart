import 'package:flutter/material.dart';

class MovieErrorText extends StatelessWidget {
  final String message;

  const MovieErrorText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: const TextStyle(color: Colors.red),
      textAlign: TextAlign.center,
    );
  }
}
