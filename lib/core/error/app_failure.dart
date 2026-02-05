import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

/// Union type for application failures using Freezed
/// This enables exhaustive pattern matching and type-safe error handling
@freezed
sealed class AppFailure with _$AppFailure {
  /// Server-side error
  const factory AppFailure.server({
    required String message,
    int? statusCode,
    String? code,
  }) = ServerFailure;

  /// Network connectivity error
  const factory AppFailure.network({
    @Default('No internet connection') String message,
  }) = NetworkFailure;

  /// Local cache/storage error
  const factory AppFailure.cache({
    @Default('Cache operation failed') String message,
  }) = CacheFailure;

  /// Authentication error
  const factory AppFailure.authentication({
    @Default('Authentication failed') String message,
    String? code,
  }) = AuthenticationFailure;

  /// Validation error
  const factory AppFailure.validation({
    required String message,
    Map<String, List<String>>? fieldErrors,
  }) = ValidationFailure;

  /// Permission/authorization error
  const factory AppFailure.permission({
    @Default('Permission denied') String message,
  }) = PermissionFailure;

  /// Timeout error
  const factory AppFailure.timeout({
    @Default('Request timed out') String message,
  }) = TimeoutFailure;

  /// Unknown/unexpected error
  const factory AppFailure.unknown({
    @Default('An unexpected error occurred') String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UnknownFailure;
}

/// Extension methods for AppFailure
extension AppFailureX on AppFailure {
  /// Get display message for UI
  String get displayMessage => when(
    server: (message, statusCode, code) => message,
    network: (message) => message,
    cache: (message) => message,
    authentication: (message, code) => message,
    validation: (message, fieldErrors) => message,
    permission: (message) => message,
    timeout: (message) => message,
    unknown: (message, error, stackTrace) => message,
  );

  /// Check if error is recoverable (user can retry)
  bool get isRecoverable => maybeWhen(
    network: (message) => true,
    timeout: (message) => true,
    server: (message, statusCode, code) =>
        statusCode == null || statusCode >= 500,
    orElse: () => false,
  );

  /// Check if user needs to re-authenticate
  bool get requiresReAuth => maybeWhen(
    authentication: (message, code) => true,
    server: (message, statusCode, code) => statusCode == 401,
    orElse: () => false,
  );
}
