import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/popular_movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_popular_movies.dart';

/// -------------------------------
/// Mock
/// -------------------------------
class MockMovieRepository extends Mock implements MoviesRepository {}

void main() {
  late GetPopularMovies usecase;
  late MockMovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    usecase = GetPopularMovies(repository);
  });

  final testPopularMovies = [
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

  group('GetPopularMovies Usecase', () {
    test('returns list of popular movies when repository succeeds', () async {
      // arrange
      when(
        () => repository.getPopularMovies(),
      ).thenAnswer(
        (_) async => Right(testPopularMovies),
      );

      // act
      final result = await usecase();

      // assert
      expect(result, Right(testPopularMovies));
      verify(() => repository.getPopularMovies()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return Failure when repository call fails', () async {
      // arrange
      const failure = ServerFailure(message: 'Server error');
      when(
        () => repository.getPopularMovies(),
      ).thenAnswer((_) async => const Left(failure));

      // act
      final result = await usecase();

      // assert
      expect(result, const Left(failure));
      verify(() => repository.getPopularMovies()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
