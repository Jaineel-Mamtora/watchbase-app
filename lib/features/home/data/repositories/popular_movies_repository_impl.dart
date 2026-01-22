import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/datasources/popular_movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/models/popular_movies_model.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movies.dart';
import 'package:watchbase_app/features/home/domain/repositories/popular_movies_repository.dart';

class PopularMoviesRepositoryImpl implements PopularMoviesRepository {
  const PopularMoviesRepositoryImpl(
    PopularMoviesRemoteDataSource remoteDataSource,
  ) : _remoteDataSource = remoteDataSource;

  final PopularMoviesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, PopularMovieList>> getPopularMovies() async {
    try {
      final popularMoviesModel = await _remoteDataSource.fetchPopularMovies();
      return right(popularMoviesModel.toEntity());
    } on Failure catch (f) {
      return left(f);
    } catch (e) {
      return left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}
