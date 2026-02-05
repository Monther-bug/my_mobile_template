import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';

@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.server({
    required String message,
    int? statusCode,
    String? code,
  }) = ServerFailure;

  const factory AppFailure.network({
    @Default('No internet connection') String message,
  }) = NetworkFailure;

  const factory AppFailure.cache({
    @Default('Cache operation failed') String message,
  }) = CacheFailure;

  const factory AppFailure.authentication({
    @Default('Authentication failed') String message,
    String? code,
  }) = AuthenticationFailure;

  const factory AppFailure.validation({
    required String message,
    Map<String, List<String>>? fieldErrors,
  }) = ValidationFailure;

  const factory AppFailure.permission({
    @Default('Permission denied') String message,
  }) = PermissionFailure;

  const factory AppFailure.timeout({
    @Default('Request timed out') String message,
  }) = TimeoutFailure;

  const factory AppFailure.unknown({
    @Default('An unexpected error occurred') String message,
    Object? error,
    StackTrace? stackTrace,
  }) = UnknownFailure;
}

extension AppFailureX on AppFailure {
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

  bool get isRecoverable => maybeWhen(
    network: (message) => true,
    timeout: (message) => true,
    server: (message, statusCode, code) =>
        statusCode == null || statusCode >= 500,
    orElse: () => false,
  );

  bool get requiresReAuth => maybeWhen(
    authentication: (message, code) => true,
    server: (message, statusCode, code) => statusCode == 401,
    orElse: () => false,
  );
}
