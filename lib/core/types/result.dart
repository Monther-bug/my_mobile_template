import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T, E> with _$Result<T, E> {
  const factory Result.success(T data) = Success<T, E>;

  const factory Result.failure(E error) = Failure<T, E>;
}

extension ResultX<T, E> on Result<T, E> {
  bool get isSuccess => this is Success<T, E>;

  bool get isFailure => this is Failure<T, E>;

  T? get successOrNull =>
      maybeWhen(success: (data) => data, orElse: () => null);

  E? get failureOrNull =>
      maybeWhen(failure: (error) => error, orElse: () => null);

  T get successOrThrow =>
      when(success: (data) => data, failure: (error) => throw error as Object);

  Result<R, E> mapSuccess<R>(R Function(T data) transform) => when(
    success: (data) => Result.success(transform(data)),
    failure: (error) => Result.failure(error),
  );

  Result<T, R> mapFailure<R>(R Function(E error) transform) => when(
    success: (data) => Result.success(data),
    failure: (error) => Result.failure(transform(error)),
  );

  R fold<R>({
    required R Function(T data) onSuccess,
    required R Function(E error) onFailure,
  }) => when(success: onSuccess, failure: onFailure);

  Result<T, E> onSuccess(void Function(T data) action) {
    if (this is Success<T, E>) {
      action((this as Success<T, E>).data);
    }
    return this;
  }

  Result<T, E> onFailure(void Function(E error) action) {
    if (this is Failure<T, E>) {
      action((this as Failure<T, E>).error);
    }
    return this;
  }

  Future<Result<T, E>> toFuture() => Future.value(this);
}

extension AsyncResultX<T, E> on Future<Result<T, E>> {
  Future<Result<R, E>> mapSuccess<R>(R Function(T data) transform) async {
    final result = await this;
    return result.mapSuccess(transform);
  }

  Future<Result<T, R>> mapFailure<R>(R Function(E error) transform) async {
    final result = await this;
    return result.mapFailure(transform);
  }

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
