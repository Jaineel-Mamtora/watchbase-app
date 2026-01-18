import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_api/src/models/dates.dart';
import 'package:tmdb_api/src/models/movie.dart';

part 'upcoming_movies_response.g.dart';

@JsonSerializable(createToJson: false)
class UpcomingMoviesResponse {
  UpcomingMoviesResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final Dates? dates;
  final num? page;
  final List<Movie>? results;

  @JsonKey(name: 'total_pages')
  final num? totalPages;

  @JsonKey(name: 'total_results')
  final num? totalResults;

  UpcomingMoviesResponse copyWith({
    Dates? dates,
    num? page,
    List<Movie>? results,
    num? totalPages,
    num? totalResults,
  }) {
    return UpcomingMoviesResponse(
      dates: dates ?? this.dates,
      page: page ?? this.page,
      results: results ?? this.results,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
    );
  }

  factory UpcomingMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$UpcomingMoviesResponseFromJson(json);

  @override
  String toString() {
    return "$dates, $page, $results, $totalPages, $totalResults, ";
  }
}
