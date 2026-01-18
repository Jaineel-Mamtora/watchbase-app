// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingMoviesResponse _$UpcomingMoviesResponseFromJson(
  Map<String, dynamic> json,
) => UpcomingMoviesResponse(
  dates: json['dates'] == null
      ? null
      : Dates.fromJson(json['dates'] as Map<String, dynamic>),
  page: json['page'] as num?,
  results: (json['results'] as List<dynamic>?)
      ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalPages: json['total_pages'] as num?,
  totalResults: json['total_results'] as num?,
);
