import 'package:flutter/material.dart';

import 'package:watchbase_app/core/utils/platform_info.dart';
import 'package:watchbase_app/core/utils/responsive_breakpoints.dart';
import 'package:watchbase_app/features/home/domain/entities/movie_list_item.dart';
import 'package:watchbase_app/features/home/presentation/widgets/movie_card.dart';

class MovieListSection extends StatelessWidget {
  const MovieListSection({
    required this.movies,
    required this.title,
    this.isLoading = false,
    this.skeletonItemCount = 10,
    super.key,
  });

  final List<MovieListItem> movies;
  final String title;
  final bool isLoading;
  final int skeletonItemCount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        final screenWidth = constraints.maxWidth;
        final webTokens = _resolveWebSectionLayout(screenWidth);

        final posterWidth =
            webTokens?.posterWidth ??
            (screenWidth < 600
                ? screenWidth *
                      0.42 // phones
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

_WebSectionLayout? _resolveWebSectionLayout(double width) {
  if (!PlatformInfo.isWeb) {
    return null;
  }

  switch (ResponsiveBreakpoints.fromWidth(width)) {
    case ResponsiveBreakpoint.base:
      return const _WebSectionLayout(
        posterWidth: 150,
        titleHorizontalPadding: 12,
        titleVerticalPadding: 8,
        listHorizontalPadding: 10,
        cardGap: 10,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.sm:
      return const _WebSectionLayout(
        posterWidth: 170,
        titleHorizontalPadding: 14,
        titleVerticalPadding: 8,
        listHorizontalPadding: 12,
        cardGap: 12,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.md:
      return const _WebSectionLayout(
        posterWidth: 190,
        titleHorizontalPadding: 16,
        titleVerticalPadding: 8,
        listHorizontalPadding: 14,
        cardGap: 12,
        listHeightExtra: 14,
      );
    case ResponsiveBreakpoint.lg:
      return const _WebSectionLayout(
        posterWidth: 210,
        titleHorizontalPadding: 18,
        titleVerticalPadding: 10,
        listHorizontalPadding: 16,
        cardGap: 14,
        listHeightExtra: 16,
      );
    case ResponsiveBreakpoint.xl:
      return const _WebSectionLayout(
        posterWidth: 230,
        titleHorizontalPadding: 24,
        titleVerticalPadding: 10,
        listHorizontalPadding: 20,
        cardGap: 16,
        listHeightExtra: 16,
      );
    case ResponsiveBreakpoint.xxl:
      return const _WebSectionLayout(
        posterWidth: 250,
        titleHorizontalPadding: 28,
        titleVerticalPadding: 12,
        listHorizontalPadding: 24,
        cardGap: 18,
        listHeightExtra: 18,
      );
  }
}

class _WebSectionLayout {
  const _WebSectionLayout({
    required this.posterWidth,
    required this.titleHorizontalPadding,
    required this.titleVerticalPadding,
    required this.listHorizontalPadding,
    required this.cardGap,
    required this.listHeightExtra,
  });

  final double posterWidth;
  final double titleHorizontalPadding;
  final double titleVerticalPadding;
  final double listHorizontalPadding;
  final double cardGap;
  final double listHeightExtra;
}
