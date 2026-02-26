part of 'movie_list_bloc.dart';

sealed class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class MovieListFetch extends MovieListEvent {
  const MovieListFetch();
}
