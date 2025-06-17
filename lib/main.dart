import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movies_app/core/providers/navigator_provider.dart';
import 'package:movies_app/presentation/core/initial_widget.dart';

void main() {
  /*this makes sure that all Flutter plugins (like path_provider, cached_network_image...)
    are correctly initialized before starting of the app.
    It is Required when using asynchronous platform channels before runApp().*/
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigatorProvider()),
      ],
      child: const InitialWidget(),
    ),
  );
}
