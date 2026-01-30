import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/popular_movies_repository.dart';

class GetPopularMovies {
  const GetPopularMovies(PopularMoviesRepository popularMoviesRepository)
    : _popularMoviesRepository = popularMoviesRepository;

  final PopularMoviesRepository _popularMoviesRepository;

  Future<Either<Failure, List<PopularMovie>>> call() async =>
      await _popularMoviesRepository.getPopularMovies();
}
