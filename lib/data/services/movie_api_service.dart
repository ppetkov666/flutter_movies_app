import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/constants/error_messages.dart';
import 'package:movies_app/data/models/movie_dto.dart';
import 'package:movies_app/constants/api_constants.dart';

class MovieApiService {
  List<dynamic>? _cachedJsonList; // Cache the JSON list

  Future<List<MovieDto>> fetchMovies({int page = 1, int pageSize = 20}) async {
    if (page <= 0 || pageSize <= 0) {
      throw ArgumentError(ErrorMessages.invalidPageOrPageSize);
    }
    if (_cachedJsonList == null) {
      final response = await http.get(Uri.parse(ApiConstants.moviesUrl));
      if (response.statusCode != 200) {
        throw Exception(ErrorMessages.failedToLoadMovies);
      }
      try {
        _cachedJsonList = json.decode(response.body) as List<dynamic>;
      } catch (e) {
        throw Exception('${ErrorMessages.failedToParseMovies}: $e');
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
