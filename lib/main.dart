import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/app/app.dart';
import 'package:watchbase_app/core/di/di.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<MovieListBloc>(
          create: (context) => MovieListBloc(
            di<GetPopularMovies>(),
          ),
        ),
        BlocProvider<MovieListBloc>(
          create: (context) => MovieListBloc(
            di<GetTopRatedMovies>(),
          ),
        ),
      ],
      child: const WatchBaseApp(),
    ),
  );
}
