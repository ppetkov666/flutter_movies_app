import 'package:flutter/material.dart';
import 'package:movies_app/domain/entities/movie.dart';

class WatchListViewModel extends ChangeNotifier {
  final List<Movie> _savedMovies = [];

  List<Movie> get savedMovies => List.unmodifiable(_savedMovies);

  bool isSaved(Movie movie) {
    return _savedMovies.any((m) => m.id == movie.id);
  }

  void addMovie(Movie movie) {
    if (!isSaved(movie)) {
      _savedMovies.add(movie);
      notifyListeners();
    }
  }

  void removeMovie(Movie movie) {
    _savedMovies.removeWhere((m) => m.title == movie.title);
    notifyListeners();
  }

  void toggleMovie(Movie movie) {
    isSaved(movie) ? removeMovie(movie) : addMovie(movie);
  }
}
