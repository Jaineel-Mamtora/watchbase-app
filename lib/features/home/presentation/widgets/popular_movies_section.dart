import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchbase_app/core/di/di.dart';

import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_error.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_loader.dart';

class PopularMoviesSectionView extends StatelessWidget {
  const PopularMoviesSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      bloc: di<MovieListBloc>(instanceName: 'PopularBloc')
        ..add(const MovieListFetch()),
      builder: (_, state) {
        switch (state) {
          case MovieListInitial():
          case MovieListLoading():
            return const SectionLoader(title: 'Popular Movies');
          case MovieListSuccess():
            return MovieListSection(
              title: 'Popular Movies',
              movies: state.movies,
            );
          case MovieListError():
            return SectionError(
              title: 'Popular Movies',
              message: state.message,
            );
        }
      },
    );
  }
}
