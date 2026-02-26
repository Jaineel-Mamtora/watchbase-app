import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:watchbase_app/core/network/tmdb_image_url_builder.dart';
import 'package:watchbase_app/features/home/data/models/movie_model.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';

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
  List<Movie> toPopularEntity() {
    final List<Movie> popularMovies = results
        .map(
          (result) => Movie(
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

  List<Movie> toTopRatedEntity() {
    final List<Movie> topRatedMovies = results
        .map(
          (result) => Movie(
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

  List<Movie> toTrendingEntity() {
    final trendingMovies = <Movie>[];
    for (var i = 0; i < results.length; i++) {
      if (results[i].backdropPath == null) {
        continue;
      }

      final movie = Movie(
        id: results[i].id,
        title: results[i].title,
        posterUrl: TmdbImageUrlBuilder.poster(results[i].backdropPath!),
        releaseDate: results[i].releaseDate,
        voteAverage: results[i].voteAverage,
      );

      trendingMovies.add(movie);
    }

    return trendingMovies;
  }
}
