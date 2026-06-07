import 'package:http/http.dart';
import 'dart:io';

class ExceptionHandler {
  static Exception getExceptionFromResponse(Response response) {
    // You can add custom logic here to handle different types of exceptions
    // For example, you can log the exception or convert it to a custom exception type
    if (response.statusCode == 401) {
      return Exception('Unauthorized: ${response.statusCode}');
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return Exception('Client error: ${response.statusCode}');
    } else if (response.statusCode >= 500) {
      return Exception('Server error: ${response.statusCode}');
    } else {
      return Exception('Unexpected error: ${response.statusCode}');
    }
  }

  static Exception refineException(Exception e) {
    // You can add custom logic here to refine the exception
    // For example, you can check the type of the exception and return a more specific exception
    if (e is SocketException) {
      return Exception('No internet connection');
    } else {
      return e;
    }
  }
}
