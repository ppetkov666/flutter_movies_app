import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/providers/auth_provider.dart' as app;
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';
import 'package:movies_app/domain/entities/movie.dart';

class ProfileViewModel extends ChangeNotifier {
  final app.AuthProvider _authProvider;
  final WatchListViewModel _watchListViewModel;

  ProfileViewModel({
    required app.AuthProvider authProvider,
    required WatchListViewModel watchListViewModel,
  })  : _authProvider = authProvider,
        _watchListViewModel = watchListViewModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String get userEmail =>
      FirebaseAuth.instance.currentUser?.email ?? 'No email';

  int get savedMoviesCount => _watchListViewModel.savedMovies.length;

  List<Movie> get savedMovies => _watchListViewModel.savedMovies;

  DateTime? get accountCreationDate =>
      FirebaseAuth.instance.currentUser?.metadata.creationTime;

  Future<void> logout() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    try {
      // await Future.delayed(const Duration(seconds: 2)); // test only
      await _authProvider.logout();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
