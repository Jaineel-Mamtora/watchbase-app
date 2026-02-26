import 'package:flutter/material.dart';

import 'package:watchbase_app/features/home/presentation/widgets/popular_movies_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/top_rated_movies_section.dart';
import 'package:watchbase_app/features/home/presentation/widgets/trending_movies_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          TrendingMoviesSection(),
          SizedBox(height: 8),
          PopularMoviesSection(),
          SizedBox(height: 8),
          TopRatedMoviesSection(),
        ],
      ),
    );
  }
}
