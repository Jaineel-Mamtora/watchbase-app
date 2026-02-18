import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  TopRatedMoviesBloc(GetTopRatedMovies getTopRatedMovies)
    : _getTopRatedMovies = getTopRatedMovies,
      super(const TopRatedMoviesInitial()) {
    on<TopRatedMoviesFetch>(_onTopRatedMoviesFetch);
  }

  final GetTopRatedMovies _getTopRatedMovies;

  Future<void> _onTopRatedMoviesFetch(
    TopRatedMoviesFetch event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(const TopRatedMoviesLoading());
    final result = await _getTopRatedMovies();

    result.match(
      (failure) => emit(TopRatedMoviesError(failure.message)),
      (movies) => emit(TopRatedMoviesSuccess(topRatedMovies: movies)),
    );
  }
}
