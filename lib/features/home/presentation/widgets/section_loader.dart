import 'package:flutter/material.dart';

import 'package:watchbase_app/features/home/presentation/widgets/movie_list_section.dart';

class SectionLoader extends StatelessWidget {
  const SectionLoader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return MovieListSection(
      title: title,
      movies: const [],
      isLoading: true,
    );
  }
}
