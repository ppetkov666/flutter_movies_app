import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/models/movie_dto.dart';

class MovieApiService {
  static const String _url =
      'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';

  List<dynamic>? _cachedJsonList; // Cache the JSON list

  Future<List<MovieDto>> fetchMovies({int page = 1, int pageSize = 20}) async {
    if (page <= 0 || pageSize <= 0) {
      throw ArgumentError('Page and pageSize must be greater than zero.');
    }
    if (_cachedJsonList == null) {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode != 200) {
        throw Exception('Failed to load movies');
      }
      try {
        _cachedJsonList = json.decode(response.body) as List<dynamic>;
      } catch (e) {
        throw Exception('Failed to parse movies JSON: $e');
      }
    }

    final jsonList = _cachedJsonList!;

    final int start = (page - 1) * pageSize;
    if (start >= jsonList.length) {
      return [];
    }

    final int end = (start + pageSize) > jsonList.length
        ? jsonList.length
        : (start + pageSize);
    final pageItems = jsonList.sublist(start, end);

    final futures =
        pageItems.map((json) => MovieDto.fromJsonAsync(json)).toList();
    return await Future.wait(futures);
  }
}
