import 'package:movies_app/utils/time_formatter.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final List<int> ratings;
  final String poster;
  final String posterUrl;
  final String contentRating;
  final String duration;
  final String releaseDate;
  final String originalTitle;
  final String storyline;
  final List<String> actors;
  final String imdbRating;
  final double averageRating;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    required this.poster,
    required this.posterUrl,
    required this.contentRating,
    required this.duration,
    required this.releaseDate,
    required this.originalTitle,
    required this.storyline,
    required this.actors,
    required this.imdbRating,
    required this.averageRating,
  });

  String get averageRatingDisplay {
    if (ratings.isEmpty) return 'N/A';
    final avg = ratings.reduce((a, b) => a + b) / ratings.length;
    return avg.toStringAsFixed(1);
  }

  String get formattedDuration => TimeFormatter.formatDurationIso8601(duration);

  bool get hasValidImage =>
      posterUrl.isNotEmpty && posterUrl.toLowerCase() != 'n/a';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'genres': genres,
      'poster': poster,
      'posterurl': posterUrl,
      'imdbRating': imdbRating,
      'storyline': storyline,
      'actors': actors,
      'ratings': ratings,
      'contentRating': contentRating,
      'duration': duration,
      'releaseDate': releaseDate,
      'originalTitle': originalTitle,
      'averageRating': averageRating,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      year: map['year'] ?? '',
      genres: List<String>.from(map['genres'] ?? []),
      ratings: List<int>.from(map['ratings'] ?? []),
      poster: map['poster'] ?? '',
      posterUrl: map['posterurl'] ?? map['posterUrl'] ?? '',
      contentRating: map['contentRating'] ?? '',
      duration: map['duration'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      originalTitle: map['originalTitle'] ?? '',
      storyline: map['storyline'] ?? '',
      actors: List<String>.from(map['actors'] ?? []),
      imdbRating: map['imdbRating']?.toString() ?? '',
      averageRating: (map['averageRating'] != null)
          ? (map['averageRating'] is int
          ? (map['averageRating'] as int).toDouble()
          : map['averageRating'] as double)
          : 0.0,
    );
  }
}
