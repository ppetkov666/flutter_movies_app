import 'package:movies_app/utils/time_formatter.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final String posterUrl;
  final String imdbRating;
  final bool hasValidImage;
  final String storyline;
  final List<String> actors;
  final List<int> ratings;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final String originalTitle;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.imdbRating,
    required this.hasValidImage,
    required this.storyline,
    required this.actors,
    required this.ratings,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.originalTitle,
  });

  String get averageRating {
    if (ratings.isEmpty) return 'N/A';
    final avg = ratings.reduce((a, b) => a + b) / ratings.length;
    return avg.toStringAsFixed(1);
  }

  String get formattedDuration => TimeFormatter.formatDurationIso8601(duration);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'genres': genres,
      'posterUrl': posterUrl,
      'imdbRating': imdbRating,
      'hasValidImage': hasValidImage,
      'storyline': storyline,
      'actors': actors,
      'ratings': ratings,
      'contentRating': contentRating,
      'duration': duration,
      'releaseDate': releaseDate,
      'originalTitle': originalTitle,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      year: map['year'] ?? '',
      genres: List<String>.from(map['genres'] ?? []),
      posterUrl: map['posterUrl'] ?? '',
      imdbRating: map['imdbRating'] ?? '',
      hasValidImage: map['hasValidImage'] ?? false,
      storyline: map['storyline'] ?? '',
      actors: List<String>.from(map['actors'] ?? []),
      ratings: List<int>.from(map['ratings'] ?? []),
      contentRating: map['contentRating'] ?? '',
      duration: map['duration'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      originalTitle: map['originalTitle'] ?? '',
    );
  }
}
