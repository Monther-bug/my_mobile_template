import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import '../config/env_config.dart';

enum LogLevel { debug, info, warning, error }

class AppLogger {
  AppLogger._();

  static final AppLogger _instance = AppLogger._();
  static AppLogger get instance => _instance;

  static void d(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void i(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void w(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.warning,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void network(
    String method,
    String url, {
    int? statusCode,
    dynamic body,
  }) {
    if (!AppConfig.enableLogging) return;

    final status = statusCode != null ? '[$statusCode]' : '';
    d('🌐 $method $status $url', tag: 'NETWORK');
    if (body != null && kDebugMode) {
      d('Body: $body', tag: 'NETWORK');
    }
  }

  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!AppConfig.enableLogging && level != LogLevel.error) return;

    final emoji = _getEmoji(level);
    final levelName = level.name.toUpperCase();
    final tagStr = tag != null ? '[$tag]' : '';
    final formattedMessage = '$emoji $levelName $tagStr $message';

    if (kDebugMode) {
      developer.log(
        formattedMessage,
        name: tag ?? 'APP',
        error: error,
        stackTrace: stackTrace,
        level: _getLogLevel(level),
      );
    }

    if (level == LogLevel.error && error != null) {
      _reportToCrashlytics(error, stackTrace);
    }
  }

  static String _getEmoji(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '❌';
    }
  }

  static int _getLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
    }
  }

  static void _reportToCrashlytics(Object error, StackTrace? stackTrace) {}
}
