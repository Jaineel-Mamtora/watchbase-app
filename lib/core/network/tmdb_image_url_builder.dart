class TmdbImageUrlBuilder {
  static const String _baseUrlW500 = String.fromEnvironment(
    'TMDB_IMAGE_BASE_URL_W500',
  );

  static const String _baseUrlOriginal = String.fromEnvironment(
    'TMDB_IMAGE_BASE_URL_ORIGINAL',
  );

  static String poster(String posterPath, [bool isOriginal = false]) {
    if (posterPath.isEmpty) return '';
    return '${isOriginal ? _baseUrlOriginal : _baseUrlW500}/$posterPath';
  }
}
