import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/app/app.dart';
import 'package:watchbase_app/core/di/di.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/bloc/top_rated_movies_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PopularMoviesBloc>(
          create: (context) => PopularMoviesBloc(
            di<GetPopularMovies>(),
          )..add(const PopularMoviesFetch()),
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => TopRatedMoviesBloc(
            di<GetTopRatedMovies>(),
          )..add(const TopRatedMoviesFetch()),
        ),
      ],
      child: const WatchBaseApp(),
    ),
  );
}
