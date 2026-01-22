import 'package:go_router/go_router.dart';

import 'package:watchbase_app/features/home/presentation/pages/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
