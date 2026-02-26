class Movie {
  const Movie({
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.popularity,
  });

  final int id;
  final String posterUrl;
  final String title;
  final DateTime releaseDate;
  final num? voteAverage;
  final num? voteCount;
  final num? popularity;
}
