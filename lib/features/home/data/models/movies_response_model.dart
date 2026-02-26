import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:watchbase_app/core/network/tmdb_image_url_builder.dart';
import 'package:watchbase_app/features/home/data/models/movie_model.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';

part 'movies_response_model.freezed.dart';
part 'movies_response_model.g.dart';

@freezed
abstract class MoviesResponseModel with _$MoviesResponseModel {
  factory MoviesResponseModel({
    required num page,
    required List<MovieModel> results,
    @JsonKey(name: 'total_pages') required num totalPages,
    @JsonKey(name: 'total_results') required num totalResults,
  }) = _MoviesResponseModel;

  factory MoviesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseModelFromJson(json);
}

extension PopularMoviesModelX on MoviesResponseModel {
  List<PopularMovie> toPopularEntity() {
    final List<PopularMovie> popularMovies = results
        .map(
          (result) => PopularMovie(
            id: result.id,
            title: result.title,
            posterUrl: TmdbImageUrlBuilder.poster(result.posterPath),
            popularity: result.popularity,
            releaseDate: result.releaseDate,
          ),
        )
        .toList();

    return popularMovies;
  }

  List<TopRatedMovie> toTopRatedEntity() {
    final List<TopRatedMovie> topRatedMovies = results
        .map(
          (result) => TopRatedMovie(
            id: result.id,
            title: result.title,
            posterUrl: TmdbImageUrlBuilder.poster(result.posterPath),
            releaseDate: result.releaseDate,
            voteAverage: result.voteAverage,
            voteCount: result.voteCount,
            popularity: result.popularity,
          ),
        )
        .toList();

    return topRatedMovies;
  }
}
