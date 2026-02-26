import 'dart:async';

import 'package:flutter/material.dart';

import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/presentation/widgets/trending_movies_carousel_card.dart';

class TrendingMoviesCarousel extends StatefulWidget {
  const TrendingMoviesCarousel({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  State<TrendingMoviesCarousel> createState() => _TrendingMoviesCarouselState();
}

class _TrendingMoviesCarouselState extends State<TrendingMoviesCarousel> {
  late final CarouselController _carouselController;
  Timer? _autoScrollTimer;
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();

    // Listen to manual scroll events to update the dots precisely
    _carouselController.addListener(_updateIndexOnScroll);

    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _carouselController.removeListener(_updateIndexOnScroll);
    _carouselController.dispose();
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) {
        if (_carouselController.hasClients) {
          final nextIndex =
              (_currentIndexNotifier.value + 1) % widget.movies.length;

          _carouselController.animateToItem(
            nextIndex,
            duration: const Duration(milliseconds: 800),
            curve: Curves.fastOutSlowIn,
          );
        }
      },
    );
  }

  void _pauseAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void _updateIndexOnScroll() {
    if (!_carouselController.hasClients) return;

    final double itemWidth = MediaQuery.sizeOf(context).width;

    final int rawIndex = (_carouselController.offset / itemWidth).round();
    final int clampedIndex = rawIndex.clamp(0, widget.movies.length - 1);

    if (_currentIndexNotifier.value != clampedIndex) {
      _currentIndexNotifier.value = clampedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    final posterWidth = media.width;
    final posterHeight = (posterWidth - 24.0) * (281.0 / 500.0);
    return Column(
      mainAxisSize: .min,
      children: [
        NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              _pauseAutoScroll();
            } else if (notification is ScrollEndNotification) {
              _startAutoScroll();
            }
            return false;
          },
          child: SizedBox(
            height: posterHeight,
            child: CarouselView.weighted(
              enableSplash: false,
              controller: _carouselController,
              itemSnapping: true,
              flexWeights: [1],
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              children: widget.movies
                  .map(
                    (movie) => TrendingMoviesCarouselCard(
                      movie: movie,
                      expandedWidth: posterWidth,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ValueListenableBuilder(
          valueListenable: _currentIndexNotifier,
          builder: (context, currentIndex, _) {
            return Row(
              mainAxisAlignment: .center,
              children: List.generate(
                widget.movies.length,
                (index) {
                  final isActive = index == currentIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: 8.0,
                    width: isActive ? 24.0 : 8.0,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
