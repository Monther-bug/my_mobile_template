import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  final bool logRequest;
  final bool logRequestHeader;
  final bool logRequestBody;
  final bool logResponseHeader;
  final bool logResponseBody;
  final bool logError;
  final void Function(String message)? customLogger;

  LoggingInterceptor({
    this.logRequest = true,
    this.logRequestHeader = true,
    this.logRequestBody = true,
    this.logResponseHeader = false,
    this.logResponseBody = true,
    this.logError = true,
    this.customLogger,
  });

  void _log(String message) {
    if (kDebugMode) {
      if (customLogger != null) {
        customLogger!(message);
      } else {
        debugPrint(message);
      }
    }
  }

  String _formatJson(dynamic data) {
    if (data == null) return 'null';
    if (data is Map || data is List) {
      try {
        return data.toString();
      } catch (_) {
        return data.toString();
      }
    }
    return data.toString();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (logRequest) {
      final buffer = StringBuffer();
      buffer.writeln(
        '╔══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ REQUEST');
      buffer.writeln(
        '╠══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ ${options.method} ${options.uri}');

      if (logRequestHeader && options.headers.isNotEmpty) {
        buffer.writeln(
          '╠══════════════════════════════════════════════════════════',
        );
        buffer.writeln('║ Headers:');
        options.headers.forEach((key, value) {
          // Mask sensitive headers
          final maskedValue = _maskSensitiveValue(key, value);
          buffer.writeln('║   $key: $maskedValue');
        });
      }

      if (logRequestBody && options.data != null) {
        buffer.writeln(
          '╠══════════════════════════════════════════════════════════',
        );
        buffer.writeln('║ Body:');
        buffer.writeln('║ ${_formatJson(options.data)}');
      }

      buffer.writeln(
        '╚══════════════════════════════════════════════════════════',
      );
      _log(buffer.toString());
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final duration = response.requestOptions.extra['startTime'] != null
        ? DateTime.now()
              .difference(
                response.requestOptions.extra['startTime'] as DateTime,
              )
              .inMilliseconds
        : null;

    final buffer = StringBuffer();
    buffer.writeln(
      '╔══════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ RESPONSE');
    buffer.writeln(
      '╠══════════════════════════════════════════════════════════',
    );
    buffer.writeln('║ ${response.statusCode} ${response.statusMessage}');
    buffer.writeln(
      '║ ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    if (duration != null) {
      buffer.writeln('║ Duration: ${duration}ms');
    }

    if (logResponseHeader && response.headers.map.isNotEmpty) {
      buffer.writeln(
        '╠══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ Headers:');
      response.headers.forEach((key, values) {
        buffer.writeln('║   $key: ${values.join(', ')}');
      });
    }

    if (logResponseBody && response.data != null) {
      buffer.writeln(
        '╠══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ Body:');
      final bodyString = _formatJson(response.data);
      // Truncate very long responses
      if (bodyString.length > 1000) {
        buffer.writeln('║ ${bodyString.substring(0, 1000)}...[truncated]');
      } else {
        buffer.writeln('║ $bodyString');
      }
    }

    buffer.writeln(
      '╚══════════════════════════════════════════════════════════',
    );
    _log(buffer.toString());

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (logError) {
      final buffer = StringBuffer();
      buffer.writeln(
        '╔══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ ERROR');
      buffer.writeln(
        '╠══════════════════════════════════════════════════════════',
      );
      buffer.writeln('║ ${err.type.name}');
      buffer.writeln(
        '║ ${err.requestOptions.method} ${err.requestOptions.uri}',
      );
      buffer.writeln('║ Message: ${err.message}');

      if (err.response != null) {
        buffer.writeln(
          '╠══════════════════════════════════════════════════════════',
        );
        buffer.writeln('║ Response:');
        buffer.writeln(
          '║ Status: ${err.response?.statusCode} ${err.response?.statusMessage}',
        );
        if (err.response?.data != null) {
          buffer.writeln('║ Body: ${_formatJson(err.response?.data)}');
        }
      }

      buffer.writeln(
        '╚══════════════════════════════════════════════════════════',
      );
      _log(buffer.toString());
    }

    handler.next(err);
  }

  /// Mask sensitive header values like Authorization
  String _maskSensitiveValue(String key, dynamic value) {
    final sensitiveKeys = [
      'authorization',
      'x-api-key',
      'cookie',
      'set-cookie',
    ];
    if (sensitiveKeys.contains(key.toLowerCase())) {
      final str = value.toString();
      if (str.length > 10) {
        return '${str.substring(0, 10)}...[MASKED]';
      }
      return '[MASKED]';
    }
    return value.toString();
  }
}

class PerformanceInterceptor extends Interceptor {
  final void Function(String url, int durationMs)? onRequestComplete;
  final int slowThresholdMs;

  PerformanceInterceptor({this.onRequestComplete, this.slowThresholdMs = 3000});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['startTime'] = DateTime.now();
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _trackPerformance(response.requestOptions);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _trackPerformance(err.requestOptions);
    handler.next(err);
  }

  void _trackPerformance(RequestOptions options) {
    final startTime = options.extra['startTime'] as DateTime?;
    if (startTime != null) {
      final duration = DateTime.now().difference(startTime).inMilliseconds;
      final url = '${options.method} ${options.path}';

      onRequestComplete?.call(url, duration);

      if (duration > slowThresholdMs && kDebugMode) {
        debugPrint('⚠️ Slow request: $url took ${duration}ms');
      }
    }
  }
}

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Set<int> retryableStatusCodes;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.retryableStatusCodes = const {408, 500, 502, 503, 504},
    this.retryDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

    if (_shouldRetry(err, retryCount)) {
      await Future.delayed(
        retryDelay * (retryCount + 1),
      ); // Exponential backoff

      try {
        final options = err.requestOptions;
        options.extra['retryCount'] = retryCount + 1;

        if (kDebugMode) {
          debugPrint(
            '🔄 Retrying request (${retryCount + 1}/$maxRetries): ${options.path}',
          );
        }

        final response = await dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          return handler.next(e);
        }
        return handler.next(err);
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err, int retryCount) {
    if (retryCount >= maxRetries) return false;

    // Retry on connection errors
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }

    // Retry on specific status codes
    final statusCode = err.response?.statusCode;
    if (statusCode != null && retryableStatusCodes.contains(statusCode)) {
      return true;
    }

    return false;
  }
}
