import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/presentation/core/initial_widget.dart';
import 'dart:async';
import 'core/providers/auth_provider.dart';

Future<void> main() async {
  runZonedGuarded(initializeApp, handleGlobalError);
}

Future<void> initializeApp() async {
  /*this makes sure that all Flutter plugins (like path_provider, cached_network_image...)
    are correctly initialized before starting of the app.
    It is Required when using asynchronous platform channels before runApp().*/
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WatchListViewModel()),
      ],
      child: const InitialWidget(),
    ),
  );
}

void handleGlobalError(Object error, StackTrace stack) {
  print('Caught global error: $error');
}
