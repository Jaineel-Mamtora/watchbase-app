import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';
import 'package:watchbase_app/features/home/presentation/bloc/movie_list_bloc.dart';

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  final testTopRatedMovies = <Movie>[
    Movie(
      id: 1,
      title: 'The Godfather',
      posterUrl: 'https://www.samplemovie/the_godfather.png',
      releaseDate: DateTime.parse('1972-03-14'),
      voteAverage: 8.7,
      voteCount: 17806,
      popularity: 100.932,
    ),
    Movie(
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

  group('MovieListBloc', () {
    test('initial state is TopRatedMoviesInitial', () {
      expect(
        MovieListBloc(mockGetTopRatedMovies).state,
        const MovieListInitial(),
      );
    });

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListSuccess] when fetch succeeds',
      build: () => MovieListBloc(mockGetTopRatedMovies),
      setUp: () {
        when(
          () => mockGetTopRatedMovies(const NoParams()),
        ).thenAnswer((_) async => Right(testTopRatedMovies));
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => [
        const MovieListLoading(),
        MovieListSuccess(testTopRatedMovies),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      },
    );

    blocTest<MovieListBloc, MovieListState>(
      'emits [MovieListLoading, MovieListError] when fetch fails',
      build: () => MovieListBloc(mockGetTopRatedMovies),
      setUp: () {
        when(() => mockGetTopRatedMovies(const NoParams())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server error')),
        );
      },
      act: (bloc) => bloc.add(const MovieListFetch()),
      expect: () => const [
        MovieListLoading(),
        MovieListError('Server error'),
      ],
      verify: (_) {
        verify(() => mockGetTopRatedMovies(const NoParams())).called(1);
        verifyNoMoreInteractions(mockGetTopRatedMovies);
      },
    );
  });
}
