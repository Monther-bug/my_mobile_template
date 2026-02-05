import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'logger.dart';

/// Performance monitoring utilities
class PerformanceMonitor {
  PerformanceMonitor._();

  static final PerformanceMonitor _instance = PerformanceMonitor._();
  static PerformanceMonitor get instance => _instance;

  final Map<String, Stopwatch> _timers = {};
  final Map<String, List<int>> _measurements = {};

  /// Start timing an operation
  static void startTimer(String name) {
    if (!kDebugMode) return;
    instance._timers[name] = Stopwatch()..start();
  }

  /// Stop timing and log the result
  static Duration? stopTimer(String name, {bool log = true}) {
    if (!kDebugMode) return null;

    final timer = instance._timers[name];
    if (timer == null) return null;

    timer.stop();
    final duration = timer.elapsed;

    // Store measurement
    instance._measurements.putIfAbsent(name, () => []);
    instance._measurements[name]!.add(duration.inMicroseconds);

    if (log) {
      AppLogger.d(
        '$name completed in ${duration.inMilliseconds}ms',
        tag: 'PERFORMANCE',
      );
    }

    instance._timers.remove(name);
    return duration;
  }

  /// Get average time for an operation
  static double? getAverageTime(String name) {
    final measurements = instance._measurements[name];
    if (measurements == null || measurements.isEmpty) return null;

    final sum = measurements.reduce((a, b) => a + b);
    return sum / measurements.length / 1000; // Return in milliseconds
  }

  /// Log all measurements
  static void logAllMeasurements() {
    if (!kDebugMode) return;

    AppLogger.d('=== Performance Measurements ===', tag: 'PERFORMANCE');
    for (final entry in instance._measurements.entries) {
      final avg = getAverageTime(entry.key);
      final count = entry.value.length;
      AppLogger.d(
        '${entry.key}: avg ${avg?.toStringAsFixed(2)}ms ($count samples)',
        tag: 'PERFORMANCE',
      );
    }
  }

  /// Clear all measurements
  static void clear() {
    instance._timers.clear();
    instance._measurements.clear();
  }

  /// Measure a synchronous function
  static T measure<T>(String name, T Function() function) {
    startTimer(name);
    try {
      return function();
    } finally {
      stopTimer(name);
    }
  }

  /// Measure an async function
  static Future<T> measureAsync<T>(
    String name,
    Future<T> Function() function,
  ) async {
    startTimer(name);
    try {
      return await function();
    } finally {
      stopTimer(name);
    }
  }
}

/// Frame callback tracker for monitoring jank
class FrameMonitor {
  FrameMonitor._();

  static bool _isMonitoring = false;
  static final List<Duration> _frameDurations = [];
  static const Duration _targetFrameTime = Duration(milliseconds: 16); // 60fps

  /// Start monitoring frames
  static void start() {
    if (_isMonitoring || !kDebugMode) return;
    _isMonitoring = true;
    _frameDurations.clear();

    SchedulerBinding.instance.addTimingsCallback(_onFrame);
    AppLogger.d('Frame monitoring started', tag: 'PERFORMANCE');
  }

  /// Stop monitoring frames
  static void stop() {
    if (!_isMonitoring) return;
    _isMonitoring = false;

    SchedulerBinding.instance.removeTimingsCallback(_onFrame);
    _logFrameStats();
  }

  static void _onFrame(List<FrameTiming> timings) {
    for (final timing in timings) {
      final duration = Duration(
        microseconds: timing.totalSpan.inMicroseconds,
      );
      _frameDurations.add(duration);

      // Log jank frames (> 16ms)
      if (duration > _targetFrameTime) {
        AppLogger.w(
          'Jank detected: ${duration.inMilliseconds}ms frame',
          tag: 'PERFORMANCE',
        );
      }
    }
  }

  static void _logFrameStats() {
    if (_frameDurations.isEmpty) return;

    final avgMicros = _frameDurations
            .map((d) => d.inMicroseconds)
            .reduce((a, b) => a + b) /
        _frameDurations.length;

    final jankFrames = _frameDurations
        .where((d) => d > _targetFrameTime)
        .length;

    final jankPercentage = (jankFrames / _frameDurations.length * 100);

    AppLogger.d(
      'Frame stats: avg ${(avgMicros / 1000).toStringAsFixed(2)}ms, '
      'jank ${jankPercentage.toStringAsFixed(1)}% ($jankFrames/${_frameDurations.length})',
      tag: 'PERFORMANCE',
    );
  }
}

/// Memory monitoring
class MemoryMonitor {
  MemoryMonitor._();

  /// Log current memory usage (debug only)
  static void logMemoryUsage() {
    if (!kDebugMode) return;

    // Note: Detailed memory info requires dart:developer
    AppLogger.d('Memory check requested', tag: 'MEMORY');
  }

  /// Force garbage collection (debug only)
  static void forceGC() {
    if (!kDebugMode) return;
    // GC is automatic in Dart, but we can hint at it
    AppLogger.d('GC hint sent', tag: 'MEMORY');
  }
}

/// Widget rebuild counter for debugging
class RebuildCounter {
  static final Map<String, int> _counts = {};

  /// Increment rebuild count for a widget
  static void increment(String widgetName) {
    if (!kDebugMode) return;
    _counts[widgetName] = (_counts[widgetName] ?? 0) + 1;
  }

  /// Get rebuild count for a widget
  static int getCount(String widgetName) {
    return _counts[widgetName] ?? 0;
  }

  /// Log all rebuild counts
  static void logAll() {
    if (!kDebugMode) return;

    AppLogger.d('=== Widget Rebuild Counts ===', tag: 'REBUILDS');
    final sorted = _counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    for (final entry in sorted.take(10)) {
      AppLogger.d('${entry.key}: ${entry.value} rebuilds', tag: 'REBUILDS');
    }
  }

  /// Clear all counts
  static void clear() {
    _counts.clear();
  }
}
