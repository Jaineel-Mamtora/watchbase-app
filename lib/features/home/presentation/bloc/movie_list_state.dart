part of 'movie_list_bloc.dart';

sealed class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

final class MovieListInitial extends MovieListState {
  const MovieListInitial();
}

final class MovieListLoading extends MovieListState {
  const MovieListLoading();
}

final class MovieListSuccess extends MovieListState {
  const MovieListSuccess(
    this.movies,
  );

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}

final class MovieListError extends MovieListState {
  const MovieListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
