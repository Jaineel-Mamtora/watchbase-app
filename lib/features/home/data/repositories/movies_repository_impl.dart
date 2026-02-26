import 'package:fpdart/fpdart.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/models/movies_list_model.dart';
import 'package:watchbase_app/features/home/data/models/movies_response_model.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  const MoviesRepositoryImpl(MoviesRemoteDataSource remoteDataSource)
    : _remoteDataSource = remoteDataSource;

  final MoviesRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<PopularMovie>>> getPopularMovies() async {
    try {
      final PopularMoviesModel moviesModel = await _remoteDataSource
          .fetchPopularMovies();
      return right(moviesModel.toPopularEntity());
    } on Failure catch (f) {
      return left(f);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TopRatedMovie>>> getTopRatedMovies() async {
    try {
      final TopRatedMoviesModel moviesModel = await _remoteDataSource
          .fetchTopRatedMovies();
      return right(moviesModel.toTopRatedEntity());
    } on Failure catch (f) {
      return left(f);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
