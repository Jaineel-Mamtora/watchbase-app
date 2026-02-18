import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<PopularMovie>>> getPopularMovies();

  Future<Either<Failure, List<TopRatedMovie>>> getTopRatedMovies();
}
