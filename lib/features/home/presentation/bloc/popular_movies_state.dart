part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

final class PopularMoviesInitial extends PopularMoviesState {
  const PopularMoviesInitial();
}

final class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading();
}

final class PopularMoviesSuccess extends PopularMoviesState {
  const PopularMoviesSuccess({
    required this.popularMovies,
  });

  final List<PopularMovie> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

final class PopularMoviesError extends PopularMoviesState {
  const PopularMoviesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
