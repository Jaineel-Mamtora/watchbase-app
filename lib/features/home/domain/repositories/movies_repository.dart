import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, List<Movie>>> getTrendingMovies();
}
