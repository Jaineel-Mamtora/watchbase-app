import 'package:json_annotation/json_annotation.dart';

import 'package:tmdb_api/src/models/movie.dart';

part 'top_rated_movies_response.g.dart';

@JsonSerializable(createToJson: false)
class TopRatedMoviesResponse {
  TopRatedMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final num? page;
  final List<Movie>? results;

  @JsonKey(name: 'total_pages')
  final num? totalPages;

  @JsonKey(name: 'total_results')
  final num? totalResults;

  TopRatedMoviesResponse copyWith({
    num? page,
    List<Movie>? results,
    num? totalPages,
    num? totalResults,
  }) {
    return TopRatedMoviesResponse(
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory TopRatedMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$TopRatedMoviesResponseFromJson(json);

  @override
  String toString() {
    return '$page, $results, $totalPages, $totalResults';
  }
}
