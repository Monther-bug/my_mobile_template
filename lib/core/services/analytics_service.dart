/// Analytics event names
abstract class AnalyticsEvents {
  // Auth events
  static const String login = 'login';
  static const String logout = 'logout';
  static const String signUp = 'sign_up';
  static const String passwordReset = 'password_reset';

  // Screen views
  static const String screenView = 'screen_view';

  // User actions
  static const String buttonClick = 'button_click';
  static const String formSubmit = 'form_submit';
  static const String search = 'search';
  static const String share = 'share';

  // E-commerce (if applicable)
  static const String viewItem = 'view_item';
  static const String addToCart = 'add_to_cart';
  static const String purchase = 'purchase';

  // Errors
  static const String error = 'error';
  static const String exception = 'exception';
}

/// Analytics parameter names
abstract class AnalyticsParams {
  static const String screenName = 'screen_name';
  static const String screenClass = 'screen_class';
  static const String buttonName = 'button_name';
  static const String itemId = 'item_id';
  static const String itemName = 'item_name';
  static const String method = 'method';
  static const String errorMessage = 'error_message';
  static const String searchTerm = 'search_term';
  static const String success = 'success';
  static const String duration = 'duration';
}

/// Analytics service interface
abstract class AnalyticsService {
  /// Initialize analytics
  Future<void> initialize();

  /// Log a custom event
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]);

  /// Log screen view
  Future<void> logScreenView(String screenName, {String? screenClass});

  /// Set user ID for analytics
  Future<void> setUserId(String? userId);

  /// Set user properties
  Future<void> setUserProperty(String name, String? value);

  /// Log login event
  Future<void> logLogin(String method);

  /// Log sign up event
  Future<void> logSignUp(String method);

  /// Log error event
  Future<void> logError(String message, {String? code, String? stackTrace});

  /// Enable/disable analytics collection
  Future<void> setAnalyticsCollectionEnabled(bool enabled);
}

/// Analytics service implementation
/// Replace with Firebase Analytics or your preferred analytics provider
class AnalyticsServiceImpl implements AnalyticsService {
  bool _initialized = false;
  bool _enabled = true;

  @override
  Future<void> initialize() async {
    // TODO: Initialize Firebase Analytics
    // await Firebase.initializeApp();
    // _analytics = FirebaseAnalytics.instance;
    _initialized = true;
  }

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]) async {
    if (!_initialized || !_enabled) return;

    // TODO: Log to Firebase Analytics
    // await _analytics.logEvent(name: name, parameters: parameters);

    // Debug logging
    _debugLog('Event: $name', parameters);
  }

  @override
  Future<void> logScreenView(String screenName, {String? screenClass}) async {
    if (!_initialized || !_enabled) return;

    // TODO: Log to Firebase Analytics
    // await _analytics.logScreenView(
    //   screenName: screenName,
    //   screenClass: screenClass,
    // );

    _debugLog('Screen View: $screenName', {'screen_class': screenClass});
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_initialized) return;

    // TODO: Set user ID in Firebase Analytics
    // await _analytics.setUserId(id: userId);

    _debugLog('Set User ID: $userId');
  }

  @override
  Future<void> setUserProperty(String name, String? value) async {
    if (!_initialized) return;

    // TODO: Set user property in Firebase Analytics
    // await _analytics.setUserProperty(name: name, value: value);

    _debugLog('Set User Property: $name = $value');
  }

  @override
  Future<void> logLogin(String method) async {
    await logEvent(AnalyticsEvents.login, {AnalyticsParams.method: method});
  }

  @override
  Future<void> logSignUp(String method) async {
    await logEvent(AnalyticsEvents.signUp, {AnalyticsParams.method: method});
  }

  @override
  Future<void> logError(
    String message, {
    String? code,
    String? stackTrace,
  }) async {
    await logEvent(AnalyticsEvents.error, {
      AnalyticsParams.errorMessage: message,
      'error_code': code,
      'stack_trace': stackTrace?.substring(0, 100),
    });
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    _enabled = enabled;

    // TODO: Set in Firebase Analytics
    // await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  void _debugLog(String message, [Map<String, dynamic>? params]) {
    assert(() {
      // ignore: avoid_print
      print('📊 Analytics: $message ${params ?? ''}');
      return true;
    }());
  }
}
