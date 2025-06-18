import 'package:flutter/foundation.dart';
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
      _movies = moviesList;
      _hasMorePages = moviesList.length == _pageSize; // If it is less that page size -  no more pages
    } catch (e) {
      _error = 'Failed to fetch movies: ${e.toString()}';
    } finally {
      _isLoading = false;
      safeNotifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMorePages) return; // to void dublicate calls or loading when no more pages

    _isLoadingMore = true;
    _error = null;
    safeNotifyListeners();

    try {
      _currentPage++;
      final moreMovies = await _repository.getMoreMovies(page: _currentPage, pageSize: _pageSize);
      if (moreMovies.isEmpty) {
        _hasMorePages = false;
      } else {
        _movies.addAll(moreMovies);
      }
    } catch (e) {
      _error = 'Failed to load more movies: ${e.toString()}';
      _currentPage--;
    } finally {
      _isLoadingMore = false;
      safeNotifyListeners();
    }
  }
}
