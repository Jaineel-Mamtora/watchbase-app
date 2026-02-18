import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';

class GetTopRatedMovies {
  GetTopRatedMovies(MoviesRepository moviesRepository)
    : _moviesRepository = moviesRepository;

  final MoviesRepository _moviesRepository;

  Future<Either<Failure, List<TopRatedMovie>>> call() async =>
      await _moviesRepository.getTopRatedMovies();
}
