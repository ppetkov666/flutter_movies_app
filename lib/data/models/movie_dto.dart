import 'package:movies_app/domain/entities/movie.dart';

class MovieDto {
  final String title;
  final String posterUrl;
  final String imdbRating;

  MovieDto({
    required this.title,
    required this.posterUrl,
    required this.imdbRating,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      title: json['title'] ?? '',
      posterUrl: json['poster'] ?? '',
      imdbRating: json['imdbRating'] ?? 'missing',
    );
  }

  Movie toDomain() {
    return Movie(
      title: title,
      posterUrl: posterUrl,
      imdbRating: imdbRating,
    );
  }
}
