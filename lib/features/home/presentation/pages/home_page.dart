import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';

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
              return ListView.builder(
                itemCount: state.popularMovies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    key: ValueKey(
                      state.popularMovies[index].id,
                    ),
                    title: Text(
                      state.popularMovies[index].title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(
                        state.popularMovies[index].releaseDate,
                      ),
                    ),
                  );
                },
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
