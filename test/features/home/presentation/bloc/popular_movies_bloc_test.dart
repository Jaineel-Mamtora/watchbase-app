import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  final testPopularMovies = <Movie>[
    Movie(
      id: 1,
      title: 'Ant-Man and the Wasp: Quantumania',
      posterUrl: 'https://www.samplemovie/antman_and_the_wasp.png',
      releaseDate: DateTime.parse('2023-02-15'),
      popularity: 8567.865,
    ),
    Movie(
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

  group('MovieListEvent', () {
    test('MovieListFetch supports value equality', () {
      expect(const MovieListFetch(), const MovieListFetch());
    });
  });

  group('MovieListState', () {
    test('MovieListInitial supports value equality', () {
      expect(const MovieListInitial(), const MovieListInitial());
    });

    test('MovieListLoading supports value equality', () {
      expect(const MovieListLoading(), const MovieListLoading());
    });

    test('MovieListSuccess supports value equality', () {
      expect(
        MovieListSuccess(testPopularMovies),
        MovieListSuccess(testPopularMovies),
      );
    });

    test('MovieListSuccess props includes popularMovies', () {
      expect(
        MovieListSuccess(testPopularMovies).props,
        [testPopularMovies],
      );
    });

    test('MovieListError supports value equality', () {
      expect(
        const MovieListError('error message'),
        const MovieListError('error message'),
      );
    });

    test('MovieListError props includes message', () {
      expect(
        const MovieListError('error message').props,
        ['error message'],
      );
    });
  });

  group('MovieListBloc', () {
    test('initial state is MovieListInitial', () {
      expect(
        MovieListBloc(mockGetPopularMovies).state,
        const MovieListInitial(),
      );
    });

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListSuccess] when fetch succeeds with movies',
      build: () => MovieListBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(const NoParams()),
        ).thenAnswer((_) async => Right(testPopularMovies));
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => [
        const MovieListLoading(),
        MovieListSuccess(testPopularMovies),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListSuccess] when fetch succeeds with empty list',
      build: () => MovieListBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(const NoParams()),
        ).thenAnswer((_) async => const Right([]));
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => [
        const MovieListLoading(),
        const MovieListSuccess([]),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListError] when fetch fails with ServerFailure',
      build: () => MovieListBloc(mockGetPopularMovies),
      setUp: () {
        when(() => mockGetPopularMovies(const NoParams())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server is down')),
        );
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => const [
        MovieListLoading(),
        MovieListError('Server is down'),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListError] when fetch fails with ConnectionFailure',
      build: () => MovieListBloc(mockGetPopularMovies),
      setUp: () {
        when(
          () => mockGetPopularMovies(const NoParams()),
        ).thenAnswer((_) async => const Left(ConnectionFailure()));
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => const [
        MovieListLoading(),
        MovieListError('Please check your internet connection'),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits loading/success sequence twice for consecutive fetch events',
      build: () => MovieListBloc(mockGetPopularMovies),
      setUp: () {
        var callCount = 0;
        when(() => mockGetPopularMovies(const NoParams())).thenAnswer((
          _,
        ) async {
          callCount++;
          if (callCount == 1) return Right(testPopularMovies);
          return const Right(<Movie>[]);
        });
      },
      act: (bloc) {
        bloc.add(const MovieListFetch());
        bloc.add(const MovieListFetch());
      },
      expect: () => [
        const MovieListLoading(),
        MovieListSuccess(testPopularMovies),
        const MovieListLoading(),
        const MovieListSuccess([]),
      ],
      verify: (_) {
        verify(() => mockGetPopularMovies(const NoParams())).called(2);
        verifyNoMoreInteractions(mockGetPopularMovies);
      },
    );
  });
}
