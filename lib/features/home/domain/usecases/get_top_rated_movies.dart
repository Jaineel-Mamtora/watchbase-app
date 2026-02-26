import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';
import 'package:watchbase_app/features/home/domain/usecases/usecase.dart';

class GetTopRatedMovies implements UseCase<List<Movie>, NoParams> {
  GetTopRatedMovies(MoviesRepository moviesRepository)
    : _moviesRepository = moviesRepository;

  final MoviesRepository _moviesRepository;

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async =>
      await _moviesRepository.getTopRatedMovies();
}
