import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/core/providers/auth_provider.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';

import 'package:movies_app/routes/app_routes.dart';
import 'package:movies_app/presentation/auth/login_screen.dart';
import 'package:movies_app/presentation/movies/view/movie_screen.dart';
import 'package:provider/single_child_widget.dart';

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  List<SingleChildWidget> _buildProviders() {
    return [
      ChangeNotifierProvider(create: (_) => NavigatorProvider()),
      ChangeNotifierProvider(create: (_) => WatchListViewModel()),
      ChangeNotifierProvider(
        create: (context) => AuthProvider(
          Provider.of<WatchListViewModel>(context, listen: false),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _buildProviders(),
      child: Consumer2<NavigatorProvider, AuthProvider>(
        builder: (context, navigatorProvider, authProvider, _) {
          return MaterialApp(
            navigatorKey: navigatorProvider.navigatorKey,
            title: 'Moviees App',
            debugShowCheckedModeBanner: false,
            home: authProvider.isAuthenticated
                ? const MoviesScreen()
                : const LoginScreen(),
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
