class PopularMovieList {
  const PopularMovieList(this.popularMovies);

  final List<PopularMovie> popularMovies;
}

class PopularMovie {
  const PopularMovie({
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.releaseDate,
    required this.popularity,
  });

  final int id;
  final String posterUrl;
  final String title;
  final DateTime releaseDate;
  final num popularity;
}
