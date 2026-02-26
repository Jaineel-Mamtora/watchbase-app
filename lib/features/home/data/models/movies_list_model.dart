import 'package:watchbase_app/features/home/data/models/movies_response_model.dart';

typedef PopularMoviesModel = MoviesResponseModel;
typedef TopRatedMoviesModel = MoviesResponseModel;

MoviesResponseModel moviesListModelFromJson(Map<String, dynamic> json) =>
    MoviesResponseModel.fromJson(json);
