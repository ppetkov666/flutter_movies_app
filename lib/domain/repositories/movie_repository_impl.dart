import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';


class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl({required this.apiService});

  @override
  Future<List<Movie>> getMovies() async {
    final dtoList = await apiService.fetchMovies();
    return dtoList.map((dto) => dto.toDomain()).toList();
  }
}
