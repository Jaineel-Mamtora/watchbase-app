import 'dart:io';

import 'package:dio/dio.dart';

import 'package:watchbase_app/core/config/app_config.dart';
import 'package:watchbase_app/core/utils/failure.dart';

class DioClient {
  static const int _maxRetryAttempts = 3;

  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.tmdbApiBaseUrl,
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
    var attempt = 0;

    while (true) {
      try {
        return await _dio.request(
          path,
          data: data,
          queryParameters: {
            'api_key': AppConfig.tmdbApiKey,
            ...?queryParameters,
          },
          options: Options(
            method: method,
            headers: {
              'accept': 'application/json',
              'Connection': 'close',
            },
          ),
        );
      } on DioException catch (e) {
        attempt += 1;

        if (_shouldRetry(e, attempt)) {
          await Future<void>.delayed(Duration(milliseconds: 250 * attempt));
          continue;
        }

        throw _handleError(e);
      }
    }
  }

  bool _shouldRetry(DioException error, int attempt) {
    if (attempt >= _maxRetryAttempts) {
      return false;
    }

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.connectionError => true,
      _ => false,
    };
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ConnectionFailure(
          message: 'Connection timed out. Please try again.',
        );
      case DioExceptionType.badResponse:
        return ServerFailure(
          statusCode: error.response?.statusCode,
          message:
              _extractServerMessage(error.response) ??
              'Unexpected server response.',
        );
      case DioExceptionType.sendTimeout:
        return const ConnectionFailure(
          message: 'Request send timed out. Please try again.',
        );
      case DioExceptionType.receiveTimeout:
        return const ConnectionFailure(
          message: 'Response timed out. Please try again.',
        );
      case DioExceptionType.badCertificate:
        return const ServerFailure(
          message: 'Could not verify server certificate.',
        );
      case DioExceptionType.cancel:
        return const ServerFailure(message: 'Request was cancelled.');
      case DioExceptionType.connectionError:
        return const ConnectionFailure(
          message: 'Connection error. Please check your internet and retry.',
        );
      case DioExceptionType.unknown:
        final errorCause = error.error;
        if (errorCause is SocketException) {
          return const ConnectionFailure(
            message: 'Network unavailable. Please check your connection.',
          );
        }

        return ServerFailure(
          message: error.message ?? 'Unexpected error occurred.',
        );
    }
  }

  String? _extractServerMessage(Response<dynamic>? response) {
    final data = response?.data;
    if (data is Map<String, dynamic>) {
      final statusMessage = data['status_message'];
      if (statusMessage is String && statusMessage.isNotEmpty) {
        return statusMessage;
      }
    }
    return response?.statusMessage;
  }
}
