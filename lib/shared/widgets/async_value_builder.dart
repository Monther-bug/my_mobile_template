import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/state/async_state.dart';
import 'loading_widget.dart';
import 'error_widget.dart' as app;

/// Generic async value builder widget
/// Handles loading, error, and success states automatically
class AsyncValueBuilder<T> extends StatelessWidget {
  final AsyncState<T> state;
  final Widget Function(T data) builder;
  final Widget? loading;
  final Widget Function(String message, VoidCallback? onRetry)? error;
  final Widget? initial;
  final VoidCallback? onRetry;

  const AsyncValueBuilder({
    super.key,
    required this.state,
    required this.builder,
    this.loading,
    this.error,
    this.initial,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => initial ?? const SizedBox.shrink(),
      loading: () => loading ?? const LoadingWidget(),
      success: (data) => builder(data),
      error: (failure) =>
          error?.call(failure.message, onRetry) ??
          app.ErrorWidget(message: failure.message, onRetry: onRetry),
    );
  }
}

/// Async value builder for Riverpod AsyncValue
class RiverpodAsyncBuilder<T> extends StatelessWidget {
  final AsyncValue<T> asyncValue;
  final Widget Function(T data) builder;
  final Widget? loading;
  final Widget Function(Object error, StackTrace? stackTrace)? errorBuilder;
  final VoidCallback? onRetry;
  final bool skipLoadingOnRefresh;

  const RiverpodAsyncBuilder({
    super.key,
    required this.asyncValue,
    required this.builder,
    this.loading,
    this.errorBuilder,
    this.onRetry,
    this.skipLoadingOnRefresh = true,
  });

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: builder,
      loading: () => loading ?? const LoadingWidget(),
      error: (error, stackTrace) =>
          errorBuilder?.call(error, stackTrace) ??
          app.ErrorWidget(message: error.toString(), onRetry: onRetry),
      skipLoadingOnRefresh: skipLoadingOnRefresh,
    );
  }
}

/// Sliver version of async value builder
class SliverAsyncValueBuilder<T> extends StatelessWidget {
  final AsyncState<T> state;
  final Widget Function(T data) builder;
  final Widget? loading;
  final Widget Function(String message, VoidCallback? onRetry)? error;
  final VoidCallback? onRetry;

  const SliverAsyncValueBuilder({
    super.key,
    required this.state,
    required this.builder,
    this.loading,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () =>
          SliverToBoxAdapter(child: loading ?? const LoadingWidget()),
      success: (data) => builder(data),
      error: (failure) => SliverToBoxAdapter(
        child:
            error?.call(failure.message, onRetry) ??
            app.ErrorWidget(message: failure.message, onRetry: onRetry),
      ),
    );
  }
}
