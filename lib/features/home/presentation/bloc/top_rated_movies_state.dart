part of 'top_rated_movies_bloc.dart';

sealed class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

final class TopRatedMoviesInitial extends TopRatedMoviesState {
  const TopRatedMoviesInitial();
}

final class TopRatedMoviesLoading extends TopRatedMoviesState {
  const TopRatedMoviesLoading();
}

final class TopRatedMoviesSuccess extends TopRatedMoviesState {
  const TopRatedMoviesSuccess({
    required this.topRatedMovies,
  });

  final List<TopRatedMovie> topRatedMovies;

  @override
  List<Object> get props => [topRatedMovies];
}

final class TopRatedMoviesError extends TopRatedMoviesState {
  const TopRatedMoviesError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
