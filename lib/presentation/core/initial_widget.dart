import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/routes/app_routes.dart';
import 'package:movies_app/presentation/auth/login_screen.dart';
import 'package:movies_app/presentation/movies/view/movie_screen.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context, listen: false);
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      navigatorKey: navigatorProvider.navigatorKey,
      title: 'Moviees App',
      debugShowCheckedModeBanner: false,
      home: authProvider.isAuthenticated
          ? const MoviesScreen()
          : const LoginScreen(),
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
