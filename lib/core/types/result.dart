import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// A Result type using Freezed for type-safe success/failure handling
/// Alternative to dartz's Either for more Flutter-idiomatic code
@freezed
sealed class Result<T, E> with _$Result<T, E> {
  /// Successful result containing data
  const factory Result.success(T data) = Success<T, E>;

  /// Failed result containing error
  const factory Result.failure(E error) = Failure<T, E>;
}

/// Extension methods for Result
extension ResultX<T, E> on Result<T, E> {
  /// Check if result is successful
  bool get isSuccess => this is Success<T, E>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T, E>;

  /// Get the success value or null
  T? get successOrNull =>
      maybeWhen(success: (data) => data, orElse: () => null);

  /// Get the failure value or null
  E? get failureOrNull =>
      maybeWhen(failure: (error) => error, orElse: () => null);

  /// Get the success value or throw
  T get successOrThrow =>
      when(success: (data) => data, failure: (error) => throw error as Object);

  /// Transform the success value
  Result<R, E> mapSuccess<R>(R Function(T data) transform) => when(
    success: (data) => Result.success(transform(data)),
    failure: (error) => Result.failure(error),
  );

  /// Transform the failure value
  Result<T, R> mapFailure<R>(R Function(E error) transform) => when(
    success: (data) => Result.success(data),
    failure: (error) => Result.failure(transform(error)),
  );

  /// Handle both cases with a single callback returning the same type
  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(E error) onFailure,
  }) => when(success: onSuccess, failure: onFailure);

  /// Execute action on success
  Result<T, E> onSuccess(void Function(T data) action) {
    if (this is Success<T, E>) {
      action((this as Success<T, E>).data);
    }
    return this;
  }

  /// Execute action on failure
  Result<T, E> onFailure(void Function(E error) action) {
    if (this is Failure<T, E>) {
      action((this as Failure<T, E>).error);
    }
    return this;
  }

  /// Convert to async result
  Future<Result<T, E>> toFuture() => Future.value(this);
}

/// Extension for chaining async Results
extension AsyncResultX<T, E> on Future<Result<T, E>> {
  /// Map success value in async context
  Future<Result<R, E>> mapSuccess<R>(R Function(T data) transform) async {
    final result = await this;
    return result.mapSuccess(transform);
  }

  /// Map failure value in async context
  Future<Result<T, R>> mapFailure<R>(R Function(E error) transform) async {
    final result = await this;
    return result.mapFailure(transform);
  }

  /// Chain another async operation on success
  Future<Result<R, E>> flatMapSuccess<R>(
    Future<Result<R, E>> Function(T data) transform,
  ) async {
    final result = await this;
    return result.when(
      success: (data) => transform(data),
      failure: (error) => Future.value(Result.failure(error)),
    );
  }
}
