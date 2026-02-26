import 'package:flutter/material.dart';

import 'package:watchbase_app/core/utils/utils.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_card.dart';

class MovieListSection extends StatelessWidget {
  const MovieListSection({
    required this.movies,
    required this.title,
    this.isLoading = false,
    this.skeletonItemCount = 10,
    super.key,
  });

  final List<Movie> movies;
  final String title;
  final bool isLoading;
  final int skeletonItemCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final screenWidth = constraints.maxWidth;
        final webTokens = resolveWebSectionLayout(screenWidth);

        final posterWidth =
            webTokens?.posterWidth ??
            (screenWidth < 600
                ? screenWidth *
                      0.28 // phones
                : screenWidth * 0.25); // tablets
        final titleHorizontalPadding =
            webTokens?.titleHorizontalPadding ?? 16.0;
        final titleVerticalPadding = webTokens?.titleVerticalPadding ?? 8.0;
        final listHorizontalPadding = webTokens?.listHorizontalPadding ?? 12.0;
        final cardGap = webTokens?.cardGap ?? 12.0;

        final posterHeight = posterWidth * (3 / 2);
        final totalItemHeight =
            posterHeight + (webTokens?.listHeightExtra ?? 16);

        final itemCount = isLoading ? skeletonItemCount : movies.length;

        return Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: titleHorizontalPadding,
                vertical: titleVerticalPadding,
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
                itemCount: itemCount,
                scrollDirection: .horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: listHorizontalPadding,
                ),
                itemBuilder: (_, index) {
                  return SizedBox(
                    width: posterWidth,
                    child: MovieCard(
                      posterSize: Size(posterWidth, posterHeight),
                      posterUrl: isLoading ? '' : movies[index].posterUrl,
                      isLoading: isLoading,
                      onTap: () {},
                    ),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(width: cardGap),
              ),
            ),
          ],
        );
      },
    );
  }
}
