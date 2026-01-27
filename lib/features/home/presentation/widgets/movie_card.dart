import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:watchbase_app/core/utils/platform_info.dart';
import 'package:watchbase_app/core/utils/radius_tokens.dart';

typedef OnMovieTap = void Function();

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.posterSize,
    required this.posterUrl,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final Size posterSize;
  final String posterUrl;
  final String title;
  final String subtitle;
  final OnMovieTap onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surface,
      elevation: 0,
      shape: PlatformInfo.isIOS
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(
                color: theme.colorScheme.outlineVariant,
                width: 1,
              ),
            ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          SizedBox(
            height: posterSize.height,
            width: posterSize.width,
            child: AspectRatio(
              aspectRatio: 2.0 / 3.0,
              child: CachedNetworkImage(
                imageUrl: posterUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: posterSize.height,
                  width: posterSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      PlatformInfo.isIOS
                          ? RadiusTokens.iosCard
                          : RadiusTokens.materialCard,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: .cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              title,
              maxLines: 2,
              overflow: .ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: .ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 6.0),
        ],
      ),
    );
  }
}
