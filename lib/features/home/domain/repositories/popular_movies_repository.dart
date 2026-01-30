import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';

abstract class PopularMoviesRepository {
  Future<Either<Failure, List<PopularMovie>>> getPopularMovies();
}
