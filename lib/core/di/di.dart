import 'package:get_it/get_it.dart';

import 'package:watchbase_app/core/network/dio_client.dart';
import 'package:watchbase_app/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/repositories/movies_repository_impl.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/bloc/top_rated_movies_bloc.dart';

final di = GetIt.instance;

Future<void> initDependencies() async {
  // Network Client
  di.registerSingleton<DioClient>(DioClient());

  // Data Sources
  di.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSource(
      di<DioClient>(),
    ),
  );

  // Repositories
  di.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(
      di<MoviesRemoteDataSource>(),
    ),
  );

  // Use cases
  di.registerLazySingleton<GetPopularMovies>(
    () => GetPopularMovies(
      di<MoviesRepository>(),
    ),
  );
  di.registerLazySingleton<GetTopRatedMovies>(
    () => GetTopRatedMovies(
      di<MoviesRepository>(),
    ),
  );

  // Bloc
  di.registerFactory<PopularMoviesBloc>(
    () => PopularMoviesBloc(
      di<GetPopularMovies>(),
    ),
  );
  di.registerFactory<TopRatedMoviesBloc>(
    () => TopRatedMoviesBloc(
      di<GetTopRatedMovies>(),
    ),
  );
}
