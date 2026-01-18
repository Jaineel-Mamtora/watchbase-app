import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable(createToJson: false)
class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'genre_ids')
  final List<num>? genreIds;
  final int? id;

  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  final num? popularity;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'release_date')
  final DateTime? releaseDate;
  final String? title;
  final bool? video;

  @JsonKey(name: 'vote_average')
  final num? voteAverage;

  @JsonKey(name: 'vote_count')
  final num? voteCount;

  Movie copyWith({
    bool? adult,
    String? backdropPath,
    List<num>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    num? popularity,
    String? posterPath,
    DateTime? releaseDate,
    String? title,
    bool? video,
    num? voteAverage,
    num? voteCount,
  }) {
    return Movie(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      genreIds: genreIds ?? this.genreIds,
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      releaseDate: releaseDate ?? this.releaseDate,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  @override
  String toString() {
    return '$adult, $backdropPath, $genreIds, $id, $originalLanguage, '
        '$originalTitle, $overview, $popularity, $posterPath, $releaseDate, '
        '$title, $video, $voteAverage, $voteCount';
  }
}
