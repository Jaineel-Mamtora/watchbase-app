import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/usecase.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  // Use a base UseCase interface here, not the concrete implementation
  final UseCase<List<Movie>, NoParams> _getMoviesUseCase;

  MovieListBloc(this._getMoviesUseCase) : super(const MovieListInitial()) {
    on<MovieListFetch>(_onFetch);
  }

  Future<void> _onFetch(
    MovieListFetch event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListLoading());
    final result = await _getMoviesUseCase(const NoParams());

    result.match(
      (failure) => emit(MovieListError(failure.message)),
      (movies) => emit(MovieListSuccess(movies)),
    );
  }
}
