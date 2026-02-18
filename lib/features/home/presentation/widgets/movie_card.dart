import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:watchbase_app/core/utils/platform_info.dart';
import 'package:watchbase_app/core/utils/radius_tokens.dart';

typedef OnMovieTap = void Function();

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.posterSize,
    required this.posterUrl,
    required this.onTap,
    this.isLoading = false,
  });

  final Size posterSize;
  final String posterUrl;
  final OnMovieTap onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(
      PlatformInfo.isIOS ? RadiusTokens.iosCard : RadiusTokens.materialCard,
    );

    final Widget cardContent = isLoading
        ? _buildShimmerPoster(context, borderRadius)
        : CachedNetworkImage(
            imageUrl: posterUrl,
            imageBuilder: (context, imageProvider) =>
                _buildPosterImage(borderRadius, imageProvider),
            placeholder: (_, url) => _buildShimmerPoster(context, borderRadius),
            errorWidget: (_, url, error) =>
                _buildErrorPoster(context, borderRadius),
          );

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
      child: SizedBox(
        height: posterSize.height,
        width: posterSize.width,
        child: AspectRatio(
          aspectRatio: 2.0 / 3.0,
          child: cardContent,
        ),
      ),
    );
  }

  Widget _buildPosterImage(
    BorderRadius borderRadius,
    ImageProvider<Object> imageProvider,
  ) {
    return Container(
      height: posterSize.height,
      width: posterSize.width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: imageProvider,
          fit: .cover,
        ),
      ),
    );
  }

  Widget _buildShimmerPoster(BuildContext context, BorderRadius borderRadius) {
    final theme = Theme.of(context);
    return Skeletonizer(
      enabled: true,
      effect: ShimmerEffect(
        baseColor: theme.colorScheme.surfaceContainerHighest,
        highlightColor: theme.colorScheme.surface,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Skeleton.shade(
        child: Container(
          height: posterSize.height,
          width: posterSize.width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorPoster(BuildContext context, BorderRadius borderRadius) {
    final theme = Theme.of(context);
    return Container(
      height: posterSize.height,
      width: posterSize.width,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: theme.colorScheme.surfaceContainerHighest,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image_outlined,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
