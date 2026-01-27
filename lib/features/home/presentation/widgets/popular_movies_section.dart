import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:watchbase_app/features/home/domain/entities/popular_movies.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_card.dart';

class PopularMoviesSection extends StatelessWidget {
  const PopularMoviesSection({
    required this.popularMovies,
    super.key,
  });

  final List<PopularMovie> popularMovies;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final screenWidth = constraints.maxWidth;

        // Adaptive width
        final posterWidth = screenWidth < 600
            ? screenWidth *
                  0.42 // phones
            : screenWidth * 0.25; // tablets / web

        final posterHeight = posterWidth * (3 / 2);

        final titleStyle = theme.textTheme.bodyMedium!;
        final subtitleStyle = theme.textTheme.bodySmall!;

        double textHeight =
            (titleStyle.fontSize! * titleStyle.height! * 2) +
            subtitleStyle.fontSize! * subtitleStyle.height!;

        final totalItemHeight =
            posterHeight +
            6 + // spacing
            textHeight +
            6 + // spacing
            16; // padding

        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8.0,
              ),
              child: Text(
                'Popular Movies',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                ),
              ),
            ),
            SizedBox(
              height: totalItemHeight,
              child: ListView.separated(
                itemCount: popularMovies.length,
                scrollDirection: .horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemBuilder: (_, index) {
                  return SizedBox(
                    width: posterWidth,
                    child: MovieCard(
                      posterSize: Size(posterWidth, posterHeight),
                      posterUrl: popularMovies[index].posterUrl,
                      title: popularMovies[index].title,
                      subtitle: DateFormat.yMMMMd().format(
                        popularMovies[index].releaseDate,
                      ),
                      onTap: () {},
                    ),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(width: 12.0),
              ),
            ),
          ],
        );
      },
    );
  }
}
