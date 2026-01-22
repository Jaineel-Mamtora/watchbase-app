// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PopularMoviesModel _$PopularMoviesModelFromJson(Map<String, dynamic> json) =>
    _PopularMoviesModel(
      page: json['page'] as num,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as num,
      totalResults: json['total_results'] as num,
    );

Map<String, dynamic> _$PopularMoviesModelToJson(_PopularMoviesModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
