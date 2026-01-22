import 'package:watchbase_app/core/network/dio_client.dart';
import 'package:watchbase_app/core/utils/constants.dart';
import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/models/popular_movies_model.dart';

class PopularMoviesRemoteDataSource {
  const PopularMoviesRemoteDataSource(DioClient dioClient)
    : _dioClient = dioClient;

  final DioClient _dioClient;

  Future<PopularMoviesModel> fetchPopularMovies() async {
    final response = await _dioClient.get(
      '${Constants.apiVersionV3}/movie/popular',
    );

    if (response.statusCode != 200) {
      throw ServerFailure(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    late final Map<String, dynamic> popularMoviesResponseData;

    try {
      popularMoviesResponseData = response.data;
    } catch (e) {
      throw ParsingFailure('ParsingFailure: ${e.toString()}');
    }

    final results = popularMoviesResponseData['results'];

    if (results is! List || results.isEmpty) {
      throw const NotFoundFailure('NotFoundFailure: No Popular Movies Found');
    }

    final popularMovies = PopularMoviesModel.fromJson(
      popularMoviesResponseData,
    );

    return popularMovies;
  }
}
