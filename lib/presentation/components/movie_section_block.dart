import 'package:flutter/material.dart';

class MovieSectionBlock extends StatelessWidget {
  final String title;
  final Widget? child;
  final List<Widget>? children;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;

  const MovieSectionBlock({
    super.key,
    required this.title,
    this.child,
    this.children,
    this.padding = const EdgeInsets.only(bottom: 16),
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style: titleStyle ??
                Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          if (child != null) child!,
          if (children != null)
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: children!,
            ),
        ],
      ),
    );
  }
}
