import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/models/movie_dto.dart';

class MovieApiService {
  static const String _url =
      'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';

  Future<List<MovieDto>> fetchMovies() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => MovieDto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
