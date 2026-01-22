// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:watchbase_app/features/home/data/models/movie_model.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movies.dart';

part 'popular_movies_model.freezed.dart';
part 'popular_movies_model.g.dart';

@freezed
abstract class PopularMoviesModel with _$PopularMoviesModel {
  factory PopularMoviesModel({
    required num page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required num totalPages,
    @JsonKey(name: 'total_results') required num totalResults,
  }) = _PopularMoviesModel;

  factory PopularMoviesModel.fromJson(Map<String, dynamic> json) =>
      _$PopularMoviesModelFromJson(json);
}

extension PopularMoviesModelX on PopularMoviesModel {
  PopularMovieList toEntity() {
    final List<PopularMovie> popularMovies = results
        .map(
          (result) => PopularMovie(
            id: result.id,
            title: result.title,
            posterUrl: result.posterPath,
            popularity: result.popularity,
            releaseDate: result.releaseDate,
          ),
        )
        .toList();

    return PopularMovieList(popularMovies);
  }
}
