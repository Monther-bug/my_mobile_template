/// Base class for all exceptions in the application
abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

/// Server exception - thrown when there's an issue with the API
class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

/// Network exception - thrown when there's no internet connection
class NetworkException extends AppException {
  const NetworkException({super.message = 'No internet connection'});
}

/// Cache exception - thrown when there's an issue with local storage
class CacheException extends AppException {
  const CacheException({super.message = 'Cache error occurred'});
}

/// Authentication exception - thrown when authentication fails
class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

/// Validation exception - thrown when input validation fails
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    super.message = 'Validation failed',
    this.fieldErrors,
  });
}

/// Timeout exception - thrown when request times out
class TimeoutException extends AppException {
  const TimeoutException({super.message = 'Connection timeout'});
}

/// Not found exception - thrown when resource is not found
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'Resource not found',
    super.statusCode = 404,
  });
}
