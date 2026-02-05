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

abstract class AnalyticsService {
  Future<void> initialize();

  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]);

  Future<void> logScreenView(String screenName, {String? screenClass});

  Future<void> setUserId(String? userId);

  Future<void> setUserProperty(String name, String? value);

  Future<void> logLogin(String method);

  Future<void> logSignUp(String method);

  Future<void> logError(String message, {String? code, String? stackTrace});

  Future<void> setAnalyticsCollectionEnabled(bool enabled);
}

class AnalyticsServiceImpl implements AnalyticsService {
  bool _initialized = false;
  bool _enabled = true;

  @override
  Future<void> initialize() async {
    // await Firebase.initializeApp();
    // _analytics = FirebaseAnalytics.instance;
    _initialized = true;
  }

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? parameters]) async {
    if (!_initialized || !_enabled) return;

    // await _analytics.logEvent(name: name, parameters: parameters);

    // Debug logging
    _debugLog('Event: $name', parameters);
  }

  @override
  Future<void> logScreenView(String screenName, {String? screenClass}) async {
    if (!_initialized || !_enabled) return;

    // await _analytics.logScreenView(
    //   screenName: screenName,
    //   screenClass: screenClass,
    // );

    _debugLog('Screen View: $screenName', {'screen_class': screenClass});
  }

  @override
  Future<void> setUserId(String? userId) async {
    if (!_initialized) return;

    // await _analytics.setUserId(id: userId);

    _debugLog('Set User ID: $userId');
  }

  @override
  Future<void> setUserProperty(String name, String? value) async {
    if (!_initialized) return;

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

    // await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  void _debugLog(String message, [Map<String, dynamic>? params]) {
    assert(() {
      // ignore: avoid_print
      print(' Analytics: $message ${params ?? ''}');
      return true;
    }());
  }
}
