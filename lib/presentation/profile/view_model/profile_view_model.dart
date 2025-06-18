import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/providers/auth_provider.dart' as app;
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final app.AuthProvider _authProvider;
  final WatchListViewModel _watchListViewModel;

  ProfileViewModel({
    required app.AuthProvider authProvider,
    required WatchListViewModel watchListViewModel,
  })  : _authProvider = authProvider,
        _watchListViewModel = watchListViewModel;

  String get userEmail => FirebaseAuth.instance.currentUser?.email ?? 'No email';
  int get savedMoviesCount => _watchListViewModel.savedMovies.length;

  void logout() {
    _authProvider.logout();
  }
}
