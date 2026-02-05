import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/env_config.dart';
import '../core/di/injection_container.dart';
import '../core/utils/logger.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  EnvConfig environment = EnvConfig.dev,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.init(environment);

  AppLogger.i(
    'Starting app in ${environment.environment.name} mode',
    tag: 'BOOTSTRAP',
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  _setupErrorHandling();

  await initDependencies();

  AppLogger.i('App initialized successfully', tag: 'BOOTSTRAP');

  runApp(
    ProviderScope(
      observers: kDebugMode ? [_ProviderLogger()] : [],
      child: await builder(),
    ),
  );
}

void _setupErrorHandling() {
  FlutterError.onError = (details) {
    AppLogger.e(
      'Flutter error: ${details.exceptionAsString()}',
      tag: 'FLUTTER_ERROR',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (kReleaseMode) {}
  };

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
