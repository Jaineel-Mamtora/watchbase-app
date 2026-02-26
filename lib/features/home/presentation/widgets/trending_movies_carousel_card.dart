import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:watchbase_app/features/home/domain/entities/movie.dart';

class TrendingMoviesCarouselCard extends StatelessWidget {
  const TrendingMoviesCarouselCard({
    super.key,
    required this.movie,
    required this.expandedWidth,
  });

  final Movie movie;
  final double expandedWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: .expand,
      children: [
        CachedNetworkImage(
          imageUrl: movie.posterUrl,
          fit: .cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: expandedWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black26,
                  Colors.black54,
                  Colors.black87,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    movie.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: .bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
