import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/core/di/di.dart';
import 'package:watchbase_app/core/utils/utils.dart';
import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/section_error.dart';
import 'package:watchbase_app/features/home/presentation/widgets/trending_movies_carousel.dart';

class TrendingMoviesSection extends StatelessWidget {
  const TrendingMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieListBloc>(
      create: (_) =>
          di<MovieListBloc>(instanceName: 'TrendingBloc')
            ..add(const MovieListFetch()),
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (context, state) {
          switch (state) {
            case MovieListInitial():
            case MovieListLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MovieListSuccess():
              final theme = Theme.of(context);
              final screenWidth = MediaQuery.sizeOf(context).width;
              final webTokens = resolveWebSectionLayout(screenWidth);
              final titleVerticalPadding =
                  webTokens?.titleVerticalPadding ?? 8.0;
              final titleHorizontalPadding =
                  webTokens?.titleHorizontalPadding ?? 16.0;
              return Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: titleHorizontalPadding,
                      vertical: titleVerticalPadding,
                    ),
                    child: Text(
                      'Trending Movies',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: .bold,
                      ),
                    ),
                  ),
                  TrendingMoviesCarousel(movies: state.movies),
                ],
              );
            case MovieListError():
              return SectionError(
                title: 'Trending Movies',
                message: state.message,
              );
          }
        },
      ),
    );
  }
}
