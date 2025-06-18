import 'package:movies_app/data/services/movie_api_service.dart';
import 'package:movies_app/domain/entities/movie.dart';
import 'package:movies_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl({required this.apiService});

  @override
  Future<List<Movie>> getMovies({int page = 1, int pageSize = 20}) async {
    final dtoList = await apiService.fetchMovies(page: page, pageSize: pageSize);
    return dtoList.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<Movie>> getMoreMovies({int page = 1, int pageSize = 20}) async {
    final dtoList = await apiService.fetchMovies(page: page, pageSize: pageSize);
    return dtoList.map((dto) => dto.toDomain()).toList();
  }
}
