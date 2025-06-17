import 'package:movies_app/domain/entities/movie.dart';
import 'package:http/http.dart' as http;

class MovieDto {
  final String title;
  final String posterUrl;
  final String imdbRating;
  final bool hasValidImage;
  final String storyline;
  final List<String> actors;
  final List<int> ratings;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final int averageRating;

  MovieDto({
    required this.title,
    required this.posterUrl,
    required this.imdbRating,
    required this.hasValidImage,
    required this.storyline,
    required this.actors,
    required this.ratings,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.averageRating,
  });

  static Future<MovieDto> fromJsonAsync(Map<String, dynamic> json) async {
    final rawPosterUrl = json['posterurl']?.toString().trim();
    final cleanedUrl = (rawPosterUrl != null && rawPosterUrl.isNotEmpty)
        ? rawPosterUrl
        : 'INVALID_URL';

    final isValid = await _checkImageExists(cleanedUrl);

    return MovieDto(
      title: json['title'] ?? '',
      posterUrl: cleanedUrl,
      imdbRating: json['imdbRating']?.toString().isNotEmpty == true
          ? json['imdbRating'].toString()
          : 'N/A',
      hasValidImage: isValid,
      storyline: json['storyline'] ?? '',
      actors: List<String>.from(json['actors'] ?? []),
      ratings: List<int>.from(json['ratings'] ?? []),
      contentRating: json['contentRating'] ?? '',
      duration: json['duration'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      averageRating: json['averageRating'] ?? 0,
    );
  }

  Movie toDomain() {
    return Movie(
      title: title,
      posterUrl: posterUrl,
      imdbRating: imdbRating,
      hasValidImage: hasValidImage,
      storyline: storyline,
      actors: actors,
      ratings: ratings,
      contentRating: contentRating,
      duration: duration,
      releaseDate: releaseDate,
      averageRating: averageRating,
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
