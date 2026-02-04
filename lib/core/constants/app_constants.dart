/// Application-wide constants
class AppConstants {
  AppConstants._();

  // API
  static const String baseUrl = 'https://api.example.com';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';

  // Hive Boxes
  static const String settingsBox = 'settings_box';
  static const String cacheBox = 'cache_box';

  // Pagination
  static const int defaultPageSize = 20;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}
