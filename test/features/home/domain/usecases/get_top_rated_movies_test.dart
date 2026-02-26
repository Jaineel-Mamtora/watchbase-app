import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/domain/entities/movie.dart';
import 'package:watchbase_app/features/home/domain/repositories/movies_repository.dart';
import 'package:watchbase_app/features/home/domain/usecases/get_top_rated_movies.dart';

class MockMovieRepository extends Mock implements MoviesRepository {}

void main() {
  late GetTopRatedMovies usecase;
  late MockMovieRepository repository;

  setUp(() {
    repository = MockMovieRepository();
    usecase = GetTopRatedMovies(repository);
  });

  final testTopRatedMovies = [
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

  group('GetTopRatedMovies Usecase', () {
    test('returns list of top-rated movies when repository succeeds', () async {
      when(
        () => repository.getTopRatedMovies(),
      ).thenAnswer((_) async => Right(testTopRatedMovies));

      final result = await usecase(const NoParams());

      expect(result, Right(testTopRatedMovies));
      verify(() => repository.getTopRatedMovies()).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('returns Failure when repository call fails', () async {
      const failure = ServerFailure(message: 'Server error');
      when(
        () => repository.getTopRatedMovies(),
      ).thenAnswer((_) async => const Left(failure));

      final result = await usecase(const NoParams());

      expect(result, const Left(failure));
      verify(() => repository.getTopRatedMovies()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
