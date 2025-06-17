import 'package:movies_app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies();
}
