import '../utils/logger.dart';

abstract class CrashReportingService {
  Future<void> initialize();

  Future<void> setUserId(String? userId);

  Future<void> setCustomKey(String key, dynamic value);

  Future<void> log(String message);

  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  });

  Future<void> recordFlutterError(dynamic error);

  Future<void> setCrashlyticsCollectionEnabled(bool enabled);
}

class CrashReportingServiceImpl implements CrashReportingService {
  bool _initialized = false;
  bool _enabled = true;

  @override
  Future<void> initialize() async {
    // await Firebase.initializeApp();
    // _crashlytics = FirebaseCrashlytics.instance;
    _initialized = true;
    AppLogger.i('Crash reporting initialized', tag: 'CRASHLYTICS');
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_initialized) return;

    // await _crashlytics.setUserIdentifier(userId ?? '');

    AppLogger.d('Crash reporting user ID set: $userId', tag: 'CRASHLYTICS');
  }

  @override
  Future<void> setCustomKey(String key, dynamic value) async {
    if (!_initialized) return;

    // await _crashlytics.setCustomKey(key, value);

    AppLogger.d('Crash reporting key set: $key = $value', tag: 'CRASHLYTICS');
  }

  @override
  Future<void> log(String message) async {
    if (!_initialized || !_enabled) return;

    // await _crashlytics.log(message);

    AppLogger.d('Crash log: $message', tag: 'CRASHLYTICS');
  }

  @override
  Future<void> recordError(
    dynamic exception,
    StackTrace? stackTrace, {
    String? reason,
    bool fatal = false,
  }) async {
    if (!_initialized || !_enabled) return;

    // await _crashlytics.recordError(
    //   exception,
    //   stackTrace,
    //   reason: reason,
    //   fatal: fatal,
    // );

    AppLogger.e(
      'Recorded error: $reason',
      tag: 'CRASHLYTICS',
      error: exception,
      stackTrace: stackTrace,
    );
  }

  @override
  Future<void> recordFlutterError(dynamic error) async {
    if (!_initialized || !_enabled) return;

    // await _crashlytics.recordFlutterError(error);

    AppLogger.e('Recorded Flutter error', tag: 'CRASHLYTICS', error: error);
  }

  @override
  Future<void> setCrashlyticsCollectionEnabled(bool enabled) async {
    _enabled = enabled;

    // await _crashlytics.setCrashlyticsCollectionEnabled(enabled);
  }
}
