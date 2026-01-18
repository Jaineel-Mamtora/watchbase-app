// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
  adult: json['adult'] as bool?,
  backdropPath: json['backdrop_path'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>?)
      ?.map((e) => e as num)
      .toList(),
  id: (json['id'] as num?)?.toInt(),
  originalLanguage: json['original_language'] as String?,
  originalTitle: json['original_title'] as String?,
  overview: json['overview'] as String?,
  popularity: json['popularity'] as num?,
  posterPath: json['poster_path'] as String?,
  releaseDate: json['release_date'] == null
      ? null
      : DateTime.parse(json['release_date'] as String),
  title: json['title'] as String?,
  video: json['video'] as bool?,
  voteAverage: json['vote_average'] as num?,
  voteCount: json['vote_count'] as num?,
);
