import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/env_config.dart';
import '../core/di/injection_container.dart';
import '../core/utils/logger.dart';

/// Bootstrap the application with the given environment configuration
Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  EnvConfig environment = EnvConfig.dev,
}) async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment configuration
  AppConfig.init(environment);

  AppLogger.i(
    'Starting app in ${environment.environment.name} mode',
    tag: 'BOOTSTRAP',
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Setup error handling
  _setupErrorHandling();

  // Initialize dependencies
  await initDependencies();

  AppLogger.i('App initialized successfully', tag: 'BOOTSTRAP');

  // Run the app
  runApp(
    ProviderScope(
      observers: kDebugMode ? [_ProviderLogger()] : [],
      child: await builder(),
    ),
  );
}

/// Setup global error handling
void _setupErrorHandling() {
  // Flutter errors
  FlutterError.onError = (details) {
    AppLogger.e(
      'Flutter error: ${details.exceptionAsString()}',
      tag: 'FLUTTER_ERROR',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kReleaseMode) {
      // Report to crash analytics (Firebase Crashlytics, Sentry, etc.)
    }
  };

  // Platform errors
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.e(
      'Uncaught error',
      tag: 'PLATFORM_ERROR',
      error: error,
      stackTrace: stack,
    );
    return true;
  };
}

/// Provider observer for debugging
class _ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    AppLogger.d(
      'Provider updated: ${provider.name ?? provider.runtimeType}',
      tag: 'RIVERPOD',
    );
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    AppLogger.d(
      'Provider added: ${provider.name ?? provider.runtimeType}',
      tag: 'RIVERPOD',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    AppLogger.d(
      'Provider disposed: ${provider.name ?? provider.runtimeType}',
      tag: 'RIVERPOD',
    );
  }
}
