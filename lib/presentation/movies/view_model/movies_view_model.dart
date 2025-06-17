import 'package:flutter/foundation.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MoviesViewModel extends ChangeNotifier {
  final MovieRepository repository;

  MoviesViewModel({required this.repository});

  List<Movie> _movies = [];
  bool _isLoading = false;
  String? _error;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMovies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _movies = await repository.getMovies();
    } catch (e) {
      _error = 'Failed to fetch movies';
    }

    _isLoading = false;
    notifyListeners();
  }
}
