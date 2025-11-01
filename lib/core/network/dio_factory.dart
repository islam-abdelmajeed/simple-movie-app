import 'dart:developer';
import 'package:dio/dio.dart';

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
        onError: (error, handler) {
          log('Dio Error: ${error.message}');
          log('Dio Error Response: ${error.response?.data}');
          log('Dio Error Status Code: ${error.response?.statusCode}');

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
