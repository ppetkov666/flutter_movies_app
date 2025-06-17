
class Movie {
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

  Movie({
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
}
