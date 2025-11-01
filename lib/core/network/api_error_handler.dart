import 'package:dio/dio.dart';

import 'api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(message: "Connection error. Please try again.");
        case DioExceptionType.cancel:
          return ApiErrorModel(message: "Request to the server was cancelled");
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(message: "Connection error. Please try again.");
        case DioExceptionType.unknown:
          return ApiErrorModel(
            message: "Connection error. Please try again.",
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(message: "Connection error. Please try again.");
        case DioExceptionType.badResponse:
          return _handleError(error.response?.data);
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(message: "Connection error. Please try again.");
        default:
          return ApiErrorModel(message: "Something went wrong");
      }
    } else {
      return ApiErrorModel(message: "Unknown error occurred");
    }
  }
}

ApiErrorModel _handleError(dynamic data) {
  if (data == null) {
    return ApiErrorModel(message: "Something went wrong");
  }

  final errors = data['errors'];

  if (errors != null) {
    if (errors['password'] != null && errors['password'] is List) {
      final passwordErrors = (errors['password'] as List).join('\n');
      return ApiErrorModel(message: passwordErrors);
    }

    if (errors['generalErrors'] != null && errors['generalErrors'] is List) {
      final generalErrors = (errors['generalErrors'] as List).join('\n');
      return ApiErrorModel(message: generalErrors);
    }
  }

  return ApiErrorModel(message: data['message'] ?? "Something went wrong");
}
