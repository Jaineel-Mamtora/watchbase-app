import 'package:flutter/material.dart';

import 'package:watchbase_app/features/home/domain/entities/movie_list_item.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_card.dart';

class MovieListSection extends StatelessWidget {
  const MovieListSection({
    required this.movies,
    required this.title,
    super.key,
  });

  final List<MovieListItem> movies;
  final String title;

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

        final totalItemHeight = posterHeight + 16;

        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: .bold,
                ),
              ),
            ),
            SizedBox(
              height: totalItemHeight,
              child: ListView.separated(
                itemCount: movies.length,
                scrollDirection: .horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                itemBuilder: (_, index) {
                  return SizedBox(
                    width: posterWidth,
                    child: MovieCard(
                      posterSize: Size(posterWidth, posterHeight),
                      posterUrl: movies[index].posterUrl,
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
