import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  PopularMoviesBloc(GetPopularMovies getPopularMovies)
    : _getPopularMovies = getPopularMovies,
      super(const PopularMoviesInitial()) {
    on<PopularMoviesFetch>(_onPopularMoviesFetch);
  }

  final GetPopularMovies _getPopularMovies;

  Future<void> _onPopularMoviesFetch(
    PopularMoviesFetch event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(const PopularMoviesLoading());
    final result = await _getPopularMovies();

    result.match(
      (failure) => emit(PopularMoviesError(failure.message)),
      (movies) => emit(PopularMoviesSuccess(popularMovies: movies)),
    );
  }
}
