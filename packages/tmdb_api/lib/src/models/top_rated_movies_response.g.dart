// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rated_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopRatedMoviesResponse _$TopRatedMoviesResponseFromJson(
  Map<String, dynamic> json,
) => TopRatedMoviesResponse(
  page: json['page'] as num?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: json['total_pages'] as num?,
  totalResults: json['total_results'] as num?,
);
