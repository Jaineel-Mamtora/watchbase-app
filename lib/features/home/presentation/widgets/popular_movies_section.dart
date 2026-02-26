import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_error.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_loader.dart';

class PopularMoviesSectionView extends StatelessWidget {
  const PopularMoviesSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (_, state) {
        switch (state) {
          case PopularMoviesInitial():
          case PopularMoviesLoading():
            return const SectionLoader(title: 'Popular Movies');
          case PopularMoviesSuccess():
            return MovieListSection(
              title: 'Popular Movies',
              movies: state.popularMovies,
            );
          case PopularMoviesError():
            return SectionError(
              title: 'Popular Movies',
              message: state.message,
            );
        }
      },
    );
  }
}
