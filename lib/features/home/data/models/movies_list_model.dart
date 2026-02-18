import 'package:watchbase_app/features/home/data/models/popular_movies_model.dart';

typedef MoviesListModel = PopularMoviesModel;
typedef TopRatedMoviesModel = PopularMoviesModel;

MoviesListModel moviesListModelFromJson(Map<String, dynamic> json) =>
    PopularMoviesModel.fromJson(json);
