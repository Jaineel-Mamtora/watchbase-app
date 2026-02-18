import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          _PopularMoviesSectionView(),
          SizedBox(height: 8),
          _TopRatedMoviesSectionView(),
        ],
      ),
    );
  }
}

class _PopularMoviesSectionView extends StatelessWidget {
  const _PopularMoviesSectionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (_, state) {
        switch (state) {
          case PopularMoviesInitial():
          case PopularMoviesLoading():
            return const _SectionLoader();
          case PopularMoviesSuccess():
            return MovieListSection(
              title: 'Popular Movies',
              movies: state.popularMovies,
            );
          case PopularMoviesError():
            return _SectionError(
              title: 'Popular Movies',
              message: state.message,
            );
        }
      },
    );
  }
}

class _TopRatedMoviesSectionView extends StatelessWidget {
  const _TopRatedMoviesSectionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (_, state) {
        switch (state) {
          case TopRatedMoviesInitial():
          case TopRatedMoviesLoading():
            return const _SectionLoader();
          case TopRatedMoviesSuccess():
            return MovieListSection(
              title: 'Top Rated Movies',
              movies: state.topRatedMovies,
            );
          case TopRatedMoviesError():
            return _SectionError(
              title: 'Top Rated Movies',
              message: state.message,
            );
        }
      },
    );
  }
}

class _SectionLoader extends StatelessWidget {
  const _SectionLoader();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class _SectionError extends StatelessWidget {
  const _SectionError({
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(message),
        ],
      ),
    );
  }
}
