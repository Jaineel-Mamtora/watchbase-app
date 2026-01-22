import 'package:dio/dio.dart';

import 'package:watchbase_app/core/utils/constants.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
  }

  Dio get dio => _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async => _request(
    'GET',
    path,
    queryParameters: queryParameters,
  );

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async => _request(
    'POST',
    path,
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async => _request(
    'PUT',
    path,
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async => _request(
    'PATCH',
    path,
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async => _request(
    'DELETE',
    path,
    data: data,
    queryParameters: queryParameters,
  );

  Future<Response> _request(
    String method,
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: {
            // TODO: insert auth token
            'accept': 'application/json',
          },
        ),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Error handling logic
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout.';
      case DioExceptionType.badResponse:
        return 'Unexpected error: ${error.response?.statusCode}';
      case DioExceptionType.sendTimeout:
        return 'Send Timeout.';
      case DioExceptionType.receiveTimeout:
        return 'Receive Timeout.';
      case DioExceptionType.badCertificate:
        return 'Bad Certificate.';
      case DioExceptionType.cancel:
        return 'Request Cancelled.';
      case DioExceptionType.connectionError:
        return 'Connection Error.';
      case DioExceptionType.unknown:
        return 'Unexpected error occurred.';
    }
  }
}
