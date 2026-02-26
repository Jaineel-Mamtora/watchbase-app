import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/datasources/movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/models/movie_model.dart';
import 'package:watchbase_app/features/home/data/models/movies_response_model.dart';
import 'package:watchbase_app/features/home/data/repositories/movies_repository_impl.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';

class MockMoviesRemoteDataSource extends Mock
    implements MoviesRemoteDataSource {}

void main() {
  late MoviesRemoteDataSource moviesRemoteDataSource;
  late MoviesRepositoryImpl moviesRepositoryImpl;

  setUp(() {
    moviesRemoteDataSource = MockMoviesRemoteDataSource();
    moviesRepositoryImpl = MoviesRepositoryImpl(
      moviesRemoteDataSource,
    );
  });

  final testPopularMoviesModel = MoviesResponseModel(
    page: 1,
    results: [
      MovieModel(
        adult: false,
        backdropPath: '/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg',
        genreIds: [28, 12, 878],
        id: 640146,
        originalLanguage: 'en',
        originalTitle: 'Ant-Man and the Wasp: Quantumania',
        overview:
            'Super-Hero partners Scott Lang and Hope van Dyne, along with '
            "with Hope's parents Janet van Dyne and Hank Pym, and Scott's "
            'daughter Cassie Lang, find themselves exploring the Quantum '
            'Realm, interacting with strange new creatures and embarking on '
            'an adventure that will push them beyond the limits of what they '
            'thought possible.',
        popularity: 8567.865,
        posterPath: '/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
        releaseDate: DateTime.parse('2023-02-15'),
        title: 'Ant-Man and the Wasp: Quantumania',
        video: false,
        voteAverage: 6.5,
        voteCount: 1886,
      ),
      MovieModel(
        adult: false,
        backdropPath: '/ovM06PdF3M8wvKb06i4sjW3xoww.jpg',
        genreIds: [878, 12, 28],
        id: 76600,
        originalLanguage: 'en',
        originalTitle: 'Avatar: The Way of Water',
        overview:
            'Set more than a decade after the events of the first film, '
            'learn the story of the Sully family (Jake, Neytiri, and their '
            'kids), the trouble that follows them, the lengths they go to '
            'keep each other safe, the battles they fight to stay alive, '
            'and the tragedies they endure.',
        popularity: 3365.913,
        posterPath: '/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
        releaseDate: DateTime.parse('2022-12-14'),
        title: 'Avatar: The Way of Water',
        video: false,
        voteAverage: 7.7,
        voteCount: 7535,
      ),
    ],
    totalPages: 10,
    totalResults: 200,
  );

  group('Movies Repository Implementation', () {
    test(
      'should return list of popular movies on remote datasource fetch success',
      () async {
        // arrange dependencies + stubs
        when(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).thenAnswer((_) async => testPopularMoviesModel);

        // act (call usecase/repository/add event)
        final Either<Failure, List<Movie>> result = await moviesRepositoryImpl
            .getPopularMovies();

        // assert outputs (states, returned values, thrown errors)
        expect(result.isRight(), isTrue);

        result.match(
          (l) => fail('Expected Right, not left $l'),
          (r) {
            expect(r, isA<List<Movie>>());
            expect(r, hasLength(2));

            // spot-check mapping
            expect(r[0].id, 640146);
            expect(r[0].title, 'Ant-Man and the Wasp: Quantumania');
            expect(r[1].id, 76600);
            expect(r[1].title, 'Avatar: The Way of Water');
          },
        );

        verify(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).called(1);
        verifyNoMoreInteractions(moviesRemoteDataSource);
      },
    );

    test(
      'should return left Failure when remote datasource throws a Failure',
      () async {
        const failure = NotFoundFailure(
          'NotFoundFailure: No Movies Found',
        );

        when(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).thenThrow(failure);

        final Either<Failure, List<Movie>> result = await moviesRepositoryImpl
            .getPopularMovies();

        expect(result.isLeft(), isTrue);
        result.match(
          (l) => expect(l, failure),
          (r) => fail('Expected Left, not right $r'),
        );

        verify(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).called(1);
        verifyNoMoreInteractions(moviesRemoteDataSource);
      },
    );

    test(
      'should wrap non-Failure errors in ServerFailure',
      () async {
        when(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).thenThrow(Exception('Some server failed'));

        final Either<Failure, List<Movie>> result = await moviesRepositoryImpl
            .getPopularMovies();

        expect(result.isLeft(), isTrue);
        result.match(
          (l) {
            expect(l, isA<ServerFailure>());
            expect(l.message, 'Exception: Some server failed');
          },
          (r) => fail('Expected Left, not right $r'),
        );

        verify(
          () => moviesRemoteDataSource.fetchPopularMovies(),
        ).called(1);
        verifyNoMoreInteractions(moviesRemoteDataSource);
      },
    );

    test(
      'should return list of top-rated movies on remote datasource fetch success',
      () async {
        when(
          () => moviesRemoteDataSource.fetchTopRatedMovies(),
        ).thenAnswer((_) async => testPopularMoviesModel);

        final Either<Failure, List<Movie>> result = await moviesRepositoryImpl
            .getTopRatedMovies();

        expect(result.isRight(), isTrue);
        result.match(
          (l) => fail('Expected Right, not left $l'),
          (r) {
            expect(r, isA<List<Movie>>());
            expect(r, hasLength(2));
            expect(r[0].voteAverage, 6.5);
            expect(r[1].voteCount, 7535);
          },
        );
        verify(
          () => moviesRemoteDataSource.fetchTopRatedMovies(),
        ).called(1);
        verifyNoMoreInteractions(moviesRemoteDataSource);
      },
    );
  });
}
