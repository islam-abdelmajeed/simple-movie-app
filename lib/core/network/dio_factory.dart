import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class DioFactory {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          log('Dio Error: ${error.message}');
          log('Dio Error Response: ${error.response?.data}');
          log('Dio Error Status Code: ${error.response?.statusCode}');

          // Send error to Sentry (safe to call even if Sentry is not initialized)
          try {
            await Sentry.captureException(
              error,
              stackTrace: error.stackTrace,
              hint: Hint.withMap({
                'url': error.requestOptions.uri.toString(),
                'method': error.requestOptions.method,
                'statusCode': error.response?.statusCode,
                'responseData': error.response?.data?.toString(),
              }),
            );
          } catch (e) {
            // Ignore Sentry errors to not interrupt error handling
            log('Failed to send error to Sentry: $e');
          }

          handler.next(error);
        },
        onRequest: (options, handler) {
          log('Dio Request: ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('Dio Response: ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
      ),
    );

    return dio;
  }
}
