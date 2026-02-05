import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/failures.dart';

sealed class AsyncState<T> {
  const AsyncState();

  factory AsyncState.initial() = AsyncInitial<T>;

  factory AsyncState.loading() = AsyncLoading<T>;

  factory AsyncState.success(T data) = AsyncSuccess<T>;

  factory AsyncState.error(Failure failure) = AsyncError<T>;

  R when<R>({
    required R Function() initial,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    return switch (this) {
      AsyncInitial() => initial(),
      AsyncLoading() => loading(),
      AsyncSuccess(:final data) => success(data),
      AsyncError(:final failure) => error(failure),
    };
  }

  R maybeWhen<R>({
    R Function()? initial,
    R Function()? loading,
    R Function(T data)? success,
    R Function(Failure failure)? error,
    required R Function() orElse,
  }) {
    return switch (this) {
      AsyncInitial() => initial?.call() ?? orElse(),
      AsyncLoading() => loading?.call() ?? orElse(),
      AsyncSuccess(:final data) => success?.call(data) ?? orElse(),
      AsyncError(:final failure) => error?.call(failure) ?? orElse(),
    };
  }

  bool get isLoading => this is AsyncLoading;
  bool get isSuccess => this is AsyncSuccess;
  bool get isError => this is AsyncError;
  bool get isInitial => this is AsyncInitial;

  T? get dataOrNull =>
      this is AsyncSuccess<T> ? (this as AsyncSuccess<T>).data : null;
  Failure? get failureOrNull =>
      this is AsyncError<T> ? (this as AsyncError<T>).failure : null;
}

class AsyncInitial<T> extends AsyncState<T> {
  const AsyncInitial();
}

class AsyncLoading<T> extends AsyncState<T> {
  const AsyncLoading();
}

class AsyncSuccess<T> extends AsyncState<T> {
  final T data;
  const AsyncSuccess(this.data);
}

class AsyncError<T> extends AsyncState<T> {
  final Failure failure;
  const AsyncError(this.failure);
}

abstract class BaseStateNotifier<T> extends StateNotifier<AsyncState<T>> {
  BaseStateNotifier() : super(const AsyncInitial());

  Future<void> execute(Future<T> Function() operation) async {
    state = AsyncState.loading();
    try {
      final result = await operation();
      state = AsyncState.success(result);
    } catch (e) {
      state = AsyncState.error(UnknownFailure(message: e.toString()));
    }
  }
}
