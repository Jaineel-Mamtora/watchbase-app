import 'package:watchbase_app/features/home/domain/entities/movie_list_item.dart';

class TopRatedMovie implements MovieListItem {
  const TopRatedMovie({
    required this.id,
    required this.posterUrl,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
  });

  @override
  final int id;

  @override
  final String posterUrl;

  @override
  final String title;

  @override
  final DateTime releaseDate;

  final num voteAverage;
  final num voteCount;
  final num popularity;
}
