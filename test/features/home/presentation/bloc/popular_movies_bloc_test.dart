import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/popular_movies_bloc.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  final testPopularMovies = <PopularMovie>[
    PopularMovie(
      id: 1,
      title: 'Ant-Man and the Wasp: Quantumania',
      posterUrl: 'https://www.samplemovie/antman_and_the_wasp.png',
      releaseDate: DateTime.parse('2023-02-15'),
      popularity: 8567.865,
    ),
    PopularMovie(
      id: 2,
      title: 'Avatar: The Way of Water',
      posterUrl: 'https://www.samplemovie/avatar_the_way_of_water.png',
      releaseDate: DateTime.parse('2022-12-14'),
      popularity: 3365.913,
    ),
  ];

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
  });

  group('PopularMoviesEvent', () {
    test('PopularMoviesFetch supports value equality', () {
      expect(const PopularMoviesFetch(), const PopularMoviesFetch());
    });
  });

  group('PopularMoviesState', () {
    test('PopularMoviesInitial supports value equality', () {
      expect(const PopularMoviesInitial(), const PopularMoviesInitial());
    });

    test('PopularMoviesLoading supports value equality', () {
      expect(const PopularMoviesLoading(), const PopularMoviesLoading());
    });

    test('PopularMoviesSuccess supports value equality', () {
      expect(
        PopularMoviesSuccess(popularMovies: testPopularMovies),
        PopularMoviesSuccess(popularMovies: testPopularMovies),
      );
    });

    test('PopularMoviesSuccess props includes popularMovies', () {
      expect(
        PopularMoviesSuccess(popularMovies: testPopularMovies).props,
        [testPopularMovies],
      );
    });

    test('PopularMoviesError supports value equality', () {
      expect(
        const PopularMoviesError('error message'),
        const PopularMoviesError('error message'),
      );
    });

    test('PopularMoviesError props includes message', () {
      expect(
        const PopularMoviesError('error message').props,
        ['error message'],
      );
    });
  });

  group('PopularMoviesBloc', () {
    test('initial state is PopularMoviesInitial', () {
      expect(
        PopularMoviesBloc(mockGetPopularMovies).state,
        const PopularMoviesInitial(),
      );
    });

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoading, PopularMoviesSuccess] when fetch succeeds with movies',
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(),
        ).thenAnswer((_) async => Right(testPopularMovies));
      },
      act: (bloc) => bloc.add(const PopularMoviesFetch()),
      expect: () => [
        const PopularMoviesLoading(),
        PopularMoviesSuccess(popularMovies: testPopularMovies),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies()).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoading, PopularMoviesSuccess] when fetch succeeds with empty list',
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(),
        ).thenAnswer((_) async => const Right([]));
      },
      act: (bloc) => bloc.add(const PopularMoviesFetch()),
      expect: () => [
        const PopularMoviesLoading(),
        const PopularMoviesSuccess(popularMovies: []),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies()).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoading, PopularMoviesError] when fetch fails with ServerFailure',
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      setUp: () {
        when(() => mockGetPopularMovies()).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server is down')),
        );
      },
      act: (bloc) => bloc.add(const PopularMoviesFetch()),
      expect: () => const [
        PopularMoviesLoading(),
        PopularMoviesError('Server is down'),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies()).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits [PopularMoviesLoading, PopularMoviesError] when fetch fails with ConnectionFailure',
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(),
        ).thenAnswer((_) async => const Left(ConnectionFailure()));
      },
      act: (bloc) => bloc.add(const PopularMoviesFetch()),
      expect: () => const [
        PopularMoviesLoading(),
        PopularMoviesError('Please check your internet connection'),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies()).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'emits loading/success sequence twice for consecutive fetch events',
      build: () => PopularMoviesBloc(mockGetPopularMovies),
      setUp: () {
        var callCount = 0;
        when(() => mockGetPopularMovies()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) return Right(testPopularMovies);
          return const Right(<PopularMovie>[]);
        });
      },
      act: (bloc) {
        bloc.add(const PopularMoviesFetch());
        bloc.add(const PopularMoviesFetch());
      },
      expect: () => [
        const PopularMoviesLoading(),
        PopularMoviesSuccess(popularMovies: testPopularMovies),
        const PopularMoviesLoading(),
        const PopularMoviesSuccess(popularMovies: []),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies()).called(2);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );
  });
}
