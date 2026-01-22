import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movies.dart';
import 'package:watchbase_app/features/home/domain/repositories/popular_movies_repository.dart';

class GetPopularMovies {
  const GetPopularMovies(PopularMoviesRepository popularMoviesRepository)
    : _popularMoviesRepository = popularMoviesRepository;

  final PopularMoviesRepository _popularMoviesRepository;

  Future<Either<Failure, PopularMovieList>> call() async =>
      await _popularMoviesRepository.getPopularMovies();
}
