import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/presentation/watch_list/view_model/watch_list_view_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final WatchListViewModel _watchListViewModel;

  User? _user;
  StreamSubscription<User?>? _authSubscription;

  User? get user => _user;

  bool get isAuthenticated => _user != null;

  AuthProvider(this._watchListViewModel) {
    _authSubscription = _auth.authStateChanges().listen(_handleAuthStateChanged);
  }

  void _handleAuthStateChanged(User? firebaseUser) {
    _onAuthStateChanged(firebaseUser);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    final wasLoggedOut = _user == null;
    _user = firebaseUser;
    notifyListeners();

    if (wasLoggedOut && _user != null) {
      await _watchListViewModel.fetchWatchList();
    }

    if (_user == null) {
      _watchListViewModel.clearWatchList();
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  Future<void> login(String email, String password) async {
    // for test purpose
    /*throw Exception("Something went wrong on purpose");*/
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
