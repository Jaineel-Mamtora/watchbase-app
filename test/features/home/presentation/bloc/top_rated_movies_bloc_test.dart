import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/top_rated_movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/top_rated_movies_bloc.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  final testTopRatedMovies = <TopRatedMovie>[
    TopRatedMovie(
      id: 1,
      title: 'The Godfather',
      posterUrl: 'https://www.samplemovie/the_godfather.png',
      releaseDate: DateTime.parse('1972-03-14'),
      voteAverage: 8.7,
      voteCount: 17806,
      popularity: 100.932,
    ),
    TopRatedMovie(
      id: 2,
      title: 'The Shawshank Redemption',
      posterUrl: 'https://www.samplemovie/the_shawshank_redemption.png',
      releaseDate: DateTime.parse('1994-09-23'),
      voteAverage: 8.7,
      voteCount: 23656,
      popularity: 98.25,
    ),
  ];

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
  });

  group('TopRatedMoviesBloc', () {
    test('initial state is TopRatedMoviesInitial', () {
      expect(
        TopRatedMoviesBloc(mockGetTopRatedMovies).state,
        const TopRatedMoviesInitial(),
      );
    });

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'emits [TopRatedMoviesLoading, TopRatedMoviesSuccess] when fetch succeeds',
      build: () => TopRatedMoviesBloc(mockGetTopRatedMovies),
      setUp: () {
        when(
          () => mockGetTopRatedMovies(),
        ).thenAnswer((_) async => Right(testTopRatedMovies));
      },
      act: (bloc) => bloc.add(const TopRatedMoviesFetch()),
      expect: () => [
        const TopRatedMoviesLoading(),
        TopRatedMoviesSuccess(topRatedMovies: testTopRatedMovies),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedMovies()).called(1);
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      },
    );

    blocTest<TopRatedMoviesBloc, TopRatedMoviesState>(
      'emits [TopRatedMoviesLoading, TopRatedMoviesError] when fetch fails',
      build: () => TopRatedMoviesBloc(mockGetTopRatedMovies),
      setUp: () {
        when(() => mockGetTopRatedMovies()).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')),
        );
      },
      act: (bloc) => bloc.add(const TopRatedMoviesFetch()),
      expect: () => const [
        TopRatedMoviesLoading(),
        TopRatedMoviesError('Server error'),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedMovies()).called(1);
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      },
    );
  });
}
