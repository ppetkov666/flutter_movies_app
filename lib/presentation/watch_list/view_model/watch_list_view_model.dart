import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/domain/entities/movie.dart';

class WatchListViewModel extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final List<Movie> _savedMovies = [];

  List<Movie> get savedMovies => List.unmodifiable(_savedMovies);

  bool isSaved(Movie movie) {
    return _savedMovies.any((m) => m.id == movie.id);
  }

  Future<void> toggleMovie(Movie movie) async {
    print('toggleMovie called for ${movie.title}');
    final user = _auth.currentUser;
    if (user == null) {
      print('User is null, cannot toggle');
      return;
    }

    try {
      if (isSaved(movie)) {
        await _removeMovie(user.uid, movie);
        print('Removed movie: ${movie.title}');
      } else {
        await _addMovie(user.uid, movie);
        print('Added movie: ${movie.title}');
      }
      notifyListeners();
    } catch (e) {
      print('Error toggling movie: $e');
    }
  }


  Future<void> _addMovie(String uid, Movie movie) async {
    final docRef =
    _firestore.collection('users').doc(uid).collection('watchlist').doc(movie.id);

    await docRef.set(movie.toMap());
    _savedMovies.add(movie);
  }

  Future<void> _removeMovie(String uid, Movie movie) async {
    final docRef =
    _firestore.collection('users').doc(uid).collection('watchlist').doc(movie.id);

    await docRef.delete();
    _savedMovies.removeWhere((m) => m.id == movie.id);
  }

  Future<void> fetchWatchList() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final snapshot =
    await _firestore.collection('users').doc(user.uid).collection('watchlist').get();

    _savedMovies
      ..clear()
      ..addAll(snapshot.docs.map((doc) => Movie.fromMap(doc.data())));

    notifyListeners();
  }

  void clearWatchList() {
    _savedMovies.clear();
    notifyListeners();
  }

/*
  // Optional: listen to realtime changes in Firestore instead of fetchWatchList()
  void listenToWatchListChanges() {
    final user = _auth.currentUser;
    if (user == null) return;

    _firestore.collection('users').doc(user.uid).collection('watchlist').snapshots().listen((snapshot) {
      _savedMovies
        ..clear()
        ..addAll(snapshot.docs.map((doc) => Movie.fromMap(doc.data())));
      notifyListeners();
    });
  }
  */
}
