import 'package:movies_app/domain/entities/movie.dart';
import 'package:http/http.dart' as http;

class MovieDto {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final List<int> ratings;
  final String posterUrl;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final String originalTitle;
  final String storyline;
  final List<String> actors;
  final String imdbRating;
  final bool hasValidImage;

  MovieDto({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.posterUrl,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.hasValidImage,
  });

  static Future<MovieDto> fromJsonAsync(Map<String, dynamic> json) async {
    final rawPosterUrl = json['posterurl']?.toString().trim();
    final cleanedUrl = (rawPosterUrl != null && rawPosterUrl.isNotEmpty)
        ? rawPosterUrl
        : 'INVALID_URL';

    final isValid = await _checkImageExists(cleanedUrl);

    return MovieDto(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      ratings: (json['ratings'] as List<dynamic>? ?? [])
          .map((e) => (e as num).toInt())
          .toList(),
      posterUrl: cleanedUrl,
      contentRating: json['contentRating'] ?? '',
      duration: json['duration'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      originalTitle: json['originalTitle'] ?? '',
      storyline: json['storyline'] ?? '',
      actors: List<String>.from(json['actors'] ?? []),
      imdbRating: json['imdbRating']?.toString().isNotEmpty == true
          ? json['imdbRating'].toString()
          : 'N/A',
      hasValidImage: isValid,
    );
  }


  Movie toDomain() {
    return Movie(
      id: id,
      title: title,
      year: year,
      genres: genres,
      ratings: ratings,
      posterUrl: posterUrl,
      contentRating: contentRating,
      duration: duration,
      releaseDate: releaseDate,
      originalTitle: originalTitle,
      storyline: storyline,
      actors: actors,
      imdbRating: imdbRating,
      hasValidImage: hasValidImage,
    );
  }


  static Future<bool> _checkImageExists(String url) async {
    if (url == 'INVALID_URL') return false;
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
