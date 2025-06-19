import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constants/error_messages.dart';
import 'package:movies_app/data/models/movie_dto.dart';
import 'package:movies_app/constants/api_constants.dart';

class MovieApiService {
  final Map<int, List<MovieDto>> _pageCache = {};

  static const int maxCachedPages = 3;

  Future<List<MovieDto>> fetchMovies({int page = 1, int pageSize = 20}) async {
    if (page <= 0 || pageSize <= 0) {
      throw ArgumentError(ErrorMessages.invalidPageOrPageSize);
    }

    if (_pageCache.containsKey(page)) {
      return _pageCache[page]!;
    }

    final response = await http.get(Uri.parse(ApiConstants.moviesUrl));
    if (response.statusCode != 200) {
      throw Exception(ErrorMessages.failedToLoadMovies);
    }

    List<dynamic> jsonList;
    try {
      jsonList = json.decode(response.body) as List<dynamic>;
    } catch (e) {
      throw Exception('${ErrorMessages.failedToParseMovies}: $e');
    }

    final int start = (page - 1) * pageSize;
    if (start >= jsonList.length) return [];

    final int end = (start + pageSize).clamp(0, jsonList.length);
    final pageItems = jsonList.sublist(start, end);

    final futures = pageItems.map((json) => MovieDto.fromJsonAsync(json)).toList();
    final movies = await Future.wait(futures);

    _pageCache[page] = movies;
    _evictOldestPageIfNeeded();

    return movies;
  }

  void _evictOldestPageIfNeeded() {
    if (_pageCache.length > maxCachedPages) {
      final oldestPage = _pageCache.keys.first;
      _pageCache.remove(oldestPage);
    }
  }
}
