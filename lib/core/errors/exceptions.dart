abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection'});
}

class CacheException extends AppException {
  const CacheException({super.message = 'Cache error occurred'});
}

class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    super.message = 'Validation failed',
    this.fieldErrors,
  });
}

class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Connection timeout'});
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}
