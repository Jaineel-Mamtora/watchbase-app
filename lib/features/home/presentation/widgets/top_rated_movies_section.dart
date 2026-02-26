import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/features/home/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_error.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_loader.dart';

class TopRatedMoviesSectionView extends StatelessWidget {
  const TopRatedMoviesSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
      builder: (_, state) {
        switch (state) {
          case TopRatedMoviesInitial():
          case TopRatedMoviesLoading():
            return const SectionLoader(title: 'Top Rated Movies');
          case TopRatedMoviesSuccess():
            return MovieListSection(
              title: 'Top Rated Movies',
              movies: state.topRatedMovies,
            );
          case TopRatedMoviesError():
            return SectionError(
              title: 'Top Rated Movies',
              message: state.message,
            );
        }
      },
    );
  }
}
