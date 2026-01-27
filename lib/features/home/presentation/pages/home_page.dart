import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';
import 'package:watchbase_app/features/home/presentation/widgets/popular_movies_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
        builder: (context, state) {
          switch (state) {
            case PopularMoviesInitial():
            case PopularMoviesLoading():
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case PopularMoviesSuccess():
              return Scaffold(
                appBar: AppBar(),
                body: ListView(
                  children: [
                    PopularMoviesSection(
                      popularMovies: state.popularMovies,
                    ),
                  ],
                ),
              );
            case PopularMoviesError():
              return Center(
                child: Text(state.message),
              );
          }
        },
      ),
    );
  }
}
