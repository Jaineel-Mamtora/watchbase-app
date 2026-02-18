import 'package:watchbase_app/core/network/dio_client.dart';
import 'package:watchbase_app/core/utils/constants.dart';
import 'package:watchbase_app/core/utils/failure.dart';
import 'package:watchbase_app/features/home/data/models/movies_list_model.dart';
import 'package:watchbase_app/features/home/domain/entities/movie_list_category.dart';

class MoviesRemoteDataSource {
  const MoviesRemoteDataSource(DioClient dioClient) : _dioClient = dioClient;

  final DioClient _dioClient;

  Future<MoviesListModel> fetchPopularMovies() async =>
      fetchMovies(MovieListCategory.popular);

  Future<TopRatedMoviesModel> fetchTopRatedMovies() async =>
      fetchMovies(MovieListCategory.topRated);

  Future<MoviesListModel> fetchMovies(MovieListCategory category) async {
    final response = await _dioClient.get(_pathFor(category));

    if (response.statusCode != 200) {
      throw ServerFailure(
        statusCode: response.statusCode,
        message: response.statusMessage,
      );
    }

    late final Map<String, dynamic> responseData;

    try {
      responseData = response.data;
    } catch (e) {
      throw ParsingFailure('ParsingFailure: ${e.toString()}');
    }

    final results = responseData['results'];

    if (results is! List || results.isEmpty) {
      throw const NotFoundFailure('NotFoundFailure: No Movies Found');
    }

    final movies = moviesListModelFromJson(responseData);

    return movies;
  }

  String _pathFor(MovieListCategory category) {
    switch (category) {
      case MovieListCategory.popular:
        return '/${Constants.apiVersionV3}/movie/popular';
      case MovieListCategory.topRated:
        return '/${Constants.apiVersionV3}/movie/top_rated';
    }
  }
}
