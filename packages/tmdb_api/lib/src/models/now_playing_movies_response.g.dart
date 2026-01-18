// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowPlayingMoviesResponse _$NowPlayingMoviesResponseFromJson(
  Map<String, dynamic> json,
) => NowPlayingMoviesResponse(
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
