import 'package:http/http.dart' as http;

class TmdbApiClient {
  const TmdbApiClient({
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  final http.Client _httpClient;
}
