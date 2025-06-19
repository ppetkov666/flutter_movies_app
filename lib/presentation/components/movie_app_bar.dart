import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/routes/app_routes.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final bool centerTitle;

  const MovieAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.centerTitle = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: actions,
      bottom: bottom,
    );
  }

  factory MovieAppBar.withDefaultActions(
    BuildContext context, {
    required Widget title,
    PreferredSizeWidget? bottom,
    Color? backgroundColor,
    bool centerTitle = false,
  }) {
    return MovieAppBar(
      title: title,
      bottom: bottom,
      backgroundColor: backgroundColor,
      centerTitle: centerTitle,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          tooltip: 'Profile',
          onPressed: () {
            Provider.of<NavigatorProvider>(context, listen: false)
                .pushNamed(AppRoutes.profile);
          },
        ),
        IconButton(
          icon: const Icon(Icons.bookmark),
          tooltip: 'Watch List',
          onPressed: () {
            Provider.of<NavigatorProvider>(context, listen: false)
                .pushNamed(AppRoutes.watchList);
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'Logout',
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}
