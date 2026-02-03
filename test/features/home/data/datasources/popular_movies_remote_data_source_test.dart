import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:watchbase_app/core/network/dio_client.dart';
import 'package:watchbase_app/core/utils/constants.dart';
import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/datasources/popular_movies_remote_data_source.dart';
import 'package:watchbase_app/features/home/data/models/popular_movies_model.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  late PopularMoviesRemoteDataSource popularMoviesRemoteDataSource;
  late MockDioClient mockDioClient;

  final baseUrl = '/${Constants.apiVersionV3}/movie/popular';

  setUp(() {
    mockDioClient = MockDioClient();
    popularMoviesRemoteDataSource = PopularMoviesRemoteDataSource(
      mockDioClient,
    );
  });

  group('Popular Movies Remote Datasource', () {
    test('should return popular movies model on success', () async {
      final mockPopularMoviesResponse = Response(
        data: <String, dynamic>{
          'page': 1,
          'results': [
            {
              'adult': false,
              'backdrop_path': '/gMJngTNfaqCSCqGD4y8lVMZXKDn.jpg',
              'genre_ids': [28, 12, 878],
              'id': 640146,
              'original_language': 'en',
              'original_title': 'Ant-Man and the Wasp: Quantumania',
              'overview':
                  'Super-Hero partners Scott Lang and Hope van Dyne, along with '
                  "with Hope's parents Janet van Dyne and Hank Pym, and Scott's "
                  'daughter Cassie Lang, find themselves exploring the Quantum '
                  'Realm, interacting with strange new creatures and embarking on '
                  'an adventure that will push them beyond the limits of what '
                  'they thought possible.',
              'popularity': 8567.865,
              'poster_path': '/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg',
              'release_date': '2023-02-15',
              'title': 'Ant-Man and the Wasp: Quantumania',
              'video': false,
              'vote_average': 6.5,
              'vote_count': 1886,
            },
            {
              'adult': false,
              'backdrop_path': '/ovM06PdF3M8wvKb06i4sjW3xoww.jpg',
              'genre_ids': [878, 12, 28],
              'id': 76600,
              'original_language': 'en',
              'original_title': 'Avatar: The Way of Water',
              'overview':
                  'Set more than a decade after the events of the first film, '
                  'learn the story of the Sully family (Jake, Neytiri, and '
                  'their kids), the trouble that follows them, the lengths they '
                  'go to keep each other safe, the battles they fight to stay '
                  'alive, and the tragedies they endure.',
              'popularity': 3365.913,
              'poster_path': '/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg',
              'release_date': '2022-12-14',
              'title': 'Avatar: The Way of Water',
              'video': false,
              'vote_average': 7.7,
              'vote_count': 7535,
            },
          ],
          'total_pages': 10,
          'total_results': 200,
        },
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      // Stub
      when(
        () => mockDioClient.get(baseUrl),
      ).thenAnswer(
        (_) async => mockPopularMoviesResponse,
      );

      // act
      final result = await popularMoviesRemoteDataSource.fetchPopularMovies();

      // assert
      expect(
        result,
        PopularMoviesModel.fromJson(mockPopularMoviesResponse.data!),
      );

      verify(
        () => mockDioClient.get(baseUrl),
      ).called(1);
      verifyNoMoreInteractions(mockDioClient);
    });

    test('should throw ServerFailure when status code is not 200', () async {
      final failureResponse = Response(
        data: {
          'status_message': 'Internal Server Error',
          'success': false,
        },
        statusCode: 500,
        statusMessage: 'Internal Server Error',
        requestOptions: RequestOptions(),
      );

      when(
        () => mockDioClient.get(baseUrl),
      ).thenAnswer(
        (_) async => failureResponse,
      );

      final call = popularMoviesRemoteDataSource.fetchPopularMovies;

      await expectLater(
        call,
        throwsA(
          isA<ServerFailure>()
              .having((e) => e.statusCode, 'statusCode', 500)
              .having((e) => e.message, 'message', 'Internal Server Error'),
        ),
      );

      verify(
        () => mockDioClient.get(baseUrl),
      ).called(1);
      verifyNoMoreInteractions(mockDioClient);
    });

    test('should throw ParsingFailure when response data is invalid', () async {
      final invalidResponse = Response(
        data: 'not-a-map',
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(
        () => mockDioClient.get(baseUrl),
      ).thenAnswer(
        (_) async => invalidResponse,
      );

      final call = popularMoviesRemoteDataSource.fetchPopularMovies;

      await expectLater(
        call,
        throwsA(
          isA<ParsingFailure>().having(
            (e) => e.message,
            'message',
            startsWith('ParsingFailure:'),
          ),
        ),
      );

      verify(
        () => mockDioClient.get(baseUrl),
      ).called(1);
      verifyNoMoreInteractions(mockDioClient);
    });

    test('should throw NotFoundFailure when results is empty', () async {
      final emptyResultsResponse = Response(
        data: {
          'page': 1,
          'results': [],
          'total_pages': 1,
          'total_results': 0,
        },
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(
        () => mockDioClient.get(baseUrl),
      ).thenAnswer(
        (_) async => emptyResultsResponse,
      );

      final call = popularMoviesRemoteDataSource.fetchPopularMovies;

      await expectLater(
        call,
        throwsA(
          isA<NotFoundFailure>().having(
            (e) => e.message,
            'message',
            'NotFoundFailure: No Popular Movies Found',
          ),
        ),
      );

      verify(
        () => mockDioClient.get(baseUrl),
      ).called(1);
      verifyNoMoreInteractions(mockDioClient);
    });

    test('should throw NotFoundFailure when results is not a list', () async {
      final invalidResultsResponse = Response(
        data: {
          'page': 1,
          'results': 'invalid',
          'total_pages': 1,
          'total_results': 1,
        },
        statusCode: 200,
        requestOptions: RequestOptions(),
      );

      when(
        () => mockDioClient.get(baseUrl),
      ).thenAnswer(
        (_) async => invalidResultsResponse,
      );

      final call = popularMoviesRemoteDataSource.fetchPopularMovies;

      await expectLater(
        call,
        throwsA(
          isA<NotFoundFailure>().having(
            (e) => e.message,
            'message',
            'NotFoundFailure: No Popular Movies Found',
          ),
        ),
      );

      verify(
        () => mockDioClient.get(baseUrl),
      ).called(1);
      verifyNoMoreInteractions(mockDioClient);
    });
  });
}
