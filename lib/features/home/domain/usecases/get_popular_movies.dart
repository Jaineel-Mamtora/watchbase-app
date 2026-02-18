import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';

class GetPopularMovies {
  GetPopularMovies(MoviesRepository moviesRepository)
    : _moviesRepository = moviesRepository;

  final MoviesRepository _moviesRepository;

  Future<Either<Failure, List<PopularMovie>>> call() async =>
      await _moviesRepository.getPopularMovies();
}
