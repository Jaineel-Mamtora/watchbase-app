part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class PopularMoviesFetch extends PopularMoviesEvent {
  const PopularMoviesFetch();
}
