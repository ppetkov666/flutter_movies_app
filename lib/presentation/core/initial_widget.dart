import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/routes/app_routes.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorProvider = Provider.of<NavigatorProvider>(context, listen: false);

    return MaterialApp(
      navigatorKey: navigatorProvider.navigatorKey,
      title: 'Moviees App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
