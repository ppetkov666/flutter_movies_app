import 'package:movies_app/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovies({int page = 1, int pageSize = 20});

  Future<List<Movie>> getMoreMovies({int page = 1, int pageSize = 20});
}

