import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchbase_app/core/di/di.dart';

import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_error.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_loader.dart';

class TopRatedMoviesSectionView extends StatelessWidget {
  const TopRatedMoviesSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      bloc: di<MovieListBloc>(instanceName: 'TopRatedBloc')
        ..add(const MovieListFetch()),
      builder: (_, state) {
        switch (state) {
          case MovieListInitial():
          case MovieListLoading():
            return const SectionLoader(title: 'Top Rated Movies');
          case MovieListSuccess():
            return MovieListSection(
              title: 'Top Rated Movies',
              movies: state.movies,
            );
          case MovieListError():
            return SectionError(
              title: 'Top Rated Movies',
              message: state.message,
            );
        }
      },
    );
  }
}
