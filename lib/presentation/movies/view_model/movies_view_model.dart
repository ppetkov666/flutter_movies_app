import 'package:flutter/foundation.dart';
import 'package:movies_app/constants/error_messages.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MoviesViewModel extends ChangeNotifier {
  bool _isDisposed = false;
  final MovieRepository _repository;

  MoviesViewModel(this._repository);

  List<Movie> _movies = [];
  List<Movie> get movies => List.unmodifiable(_movies);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  String? _error;
  String? get error => _error;

  int _currentPage = 1;
  static const int _pageSize = 20;

  bool _hasMorePages = true;
  bool get hasMorePages => _hasMorePages;

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
    _currentPage = 1;
    _hasMorePages = true;
    safeNotifyListeners();

    try {
      final moviesList = await _repository.getMovies(page: _currentPage, pageSize: _pageSize);

      // we make sure that only unique values will be loaded by id
      final uniqueMovies = <String, Movie>{};
      for (var movie in moviesList) {
        uniqueMovies[movie.id] = movie;
      }
      _movies = uniqueMovies.values.toList();

      _hasMorePages = _movies.length == _pageSize;
    } catch (e) {
      _error = 'Failed to fetch movies: ${e.toString()}';
    } finally {
      _isLoading = false;
      safeNotifyListeners();
    }
  }


  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMorePages) return; // Avoid duplicate calls or loading when no more pages

    _isLoadingMore = true;
    _error = null;
    safeNotifyListeners();

    try {
      _currentPage++;
      final moreMovies = await _repository.getMoreMovies(page: _currentPage, pageSize: _pageSize);

      if (moreMovies.isEmpty) {
        _hasMorePages = false;
      } else {
        final existingIds = _movies.map((m) => m.id).toSet();
        final newMovies = moreMovies.where((m) => !existingIds.contains(m.id));
        _movies.addAll(newMovies);
      }
    } catch (e) {
      _error = '${ErrorMessages.failedToLoadMoreMovies}: ${e.toString()}';
      _currentPage--;
    } finally {
      _isLoadingMore = false;
      safeNotifyListeners();
    }
  }

}
