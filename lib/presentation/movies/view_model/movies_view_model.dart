import 'package:flutter/foundation.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MoviesViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  final MovieRepository _repository;

  MoviesViewModel(this._repository);

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Future<void> fetchMovies() async {
    _isLoading = true;
    _error = null;
    safeNotifyListeners();

    try {
      final moviesList = await _repository.getMovies();
      _movies = moviesList;
    } catch (e) {
      _error = 'Failed to fetch movies: ${e.toString()}';
    } finally {
      _isLoading = false;
      safeNotifyListeners();
    }
  }
}
