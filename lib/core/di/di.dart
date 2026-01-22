import 'package:get_it/get_it.dart';

import 'package:watchbase_app/core/network/dio_client.dart';
import 'package:watchbase_app/features/home/data/datasources/popular_movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/repositories/popular_movies_repository_impl.dart';
import 'package:watchbase_app/features/home/domain/repositories/popular_movies_repository.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';

final di = GetIt.instance;

Future<void> initDependencies() async {
  // Network Client
  di.registerSingleton<DioClient>(DioClient());

  // Data Sources
  di.registerLazySingleton<PopularMoviesRemoteDataSource>(
    () => PopularMoviesRemoteDataSource(
      di<DioClient>(),
    ),
  );

  // Repositories
  di.registerLazySingleton<PopularMoviesRepository>(
    () => PopularMoviesRepositoryImpl(
      di<PopularMoviesRemoteDataSource>(),
    ),
  );

  // Use cases
  di.registerLazySingleton<GetPopularMovies>(
    () => GetPopularMovies(
      di<PopularMoviesRepository>(),
    ),
  );

  // Bloc
  di.registerFactory<PopularMoviesBloc>(
    () => PopularMoviesBloc(
      di<GetPopularMovies>(),
    ),
  );
}
