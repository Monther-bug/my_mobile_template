/// Base class for all failures in the application
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          statusCode == other.statusCode;

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}

/// Server failure - occurs when there's an issue with the API
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

/// Network failure - occurs when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'});
}

/// Cache failure - occurs when there's an issue with local storage
class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'});
}

/// Authentication failure - occurs when authentication fails
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed',
    super.statusCode,
  });
}

/// Validation failure - occurs when input validation fails
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    super.message = 'Validation failed',
    this.fieldErrors,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValidationFailure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          fieldErrors == other.fieldErrors;

  @override
  int get hashCode => message.hashCode ^ fieldErrors.hashCode;
}

/// Timeout failure - occurs when request times out
class TimeoutFailure extends Failure {
  const TimeoutFailure({super.message = 'Connection timeout'});
}

/// Unknown failure - occurs when an unknown error happens
class UnknownFailure extends Failure {
  const UnknownFailure({super.message = 'An unknown error occurred'});
}
