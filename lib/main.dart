import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/presentation/core/initial_widget.dart';
import 'dart:async';
import 'firebase_options.dart';

Future<void> main() async {
  runZonedGuarded(initializeApp, handleGlobalError);
}

Future<void> initializeApp() async {
  /*this makes sure that all Flutter plugins (like path_provider, cached_network_image...)
    are correctly initialized before starting of the app.
    It is Required when using asynchronous platform channels before runApp().*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const InitialWidget());
}

void handleGlobalError(Object error, StackTrace stack) {
  print('Caught global error: $error');
}
