import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

/// Local storage service using Hive
class StorageService {
  final Box _settingsBox;
  final Box _cacheBox;

  StorageService({required Box settingsBox, required Box cacheBox})
    : _settingsBox = settingsBox,
      _cacheBox = cacheBox;

  // ============ Settings Storage ============

  /// Save a setting
  Future<void> saveSetting<T>(String key, T value) async {
    await _settingsBox.put(key, value);
  }

  /// Get a setting
  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  /// Remove a setting
  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  /// Clear all settings
  Future<void> clearSettings() async {
    await _settingsBox.clear();
  }

  // ============ Cache Storage ============

  /// Save cache with optional expiry
  Future<void> saveCache<T>(String key, T value, {Duration? expiry}) async {
    final cacheData = {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await _cacheBox.put(key, cacheData);
  }

  /// Get cached data (returns null if expired)
  T? getCache<T>(String key) {
    final cacheData = _cacheBox.get(key) as Map<dynamic, dynamic>?;
    if (cacheData == null) return null;

    final timestamp = cacheData['timestamp'] as int?;
    final expiry = cacheData['expiry'] as int?;

    // Check if cache is expired
    if (timestamp != null && expiry != null) {
      final expiryTime = DateTime.fromMillisecondsSinceEpoch(
        timestamp + expiry,
      );
      if (DateTime.now().isAfter(expiryTime)) {
        removeCache(key);
        return null;
      }
    }

    return cacheData['data'] as T?;
  }

  /// Remove cached data
  Future<void> removeCache(String key) async {
    await _cacheBox.delete(key);
  }

  /// Clear all cache
  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

  /// Clear expired cache entries
  Future<void> clearExpiredCache() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final keysToRemove = <dynamic>[];

    for (final key in _cacheBox.keys) {
      final cacheData = _cacheBox.get(key) as Map<dynamic, dynamic>?;
      if (cacheData != null) {
        final timestamp = cacheData['timestamp'] as int?;
        final expiry = cacheData['expiry'] as int?;

        if (timestamp != null && expiry != null) {
          if (now > timestamp + expiry) {
            keysToRemove.add(key);
          }
        }
      }
    }

    await _cacheBox.deleteAll(keysToRemove);
  }

  // ============ Auth Token Storage ============

  /// Save auth token
  Future<void> saveAuthToken(String token) async {
    await saveSetting(AppConstants.tokenKey, token);
  }

  /// Get auth token
  String? getAuthToken() {
    return getSetting<String>(AppConstants.tokenKey);
  }

  /// Remove auth token
  Future<void> removeAuthToken() async {
    await removeSetting(AppConstants.tokenKey);
  }

  /// Check if user is logged in
  bool get isLoggedIn => getAuthToken() != null;

  // ============ Theme Mode Storage ============

  /// Save theme mode (0: system, 1: light, 2: dark)
  Future<void> saveThemeMode(int mode) async {
    await saveSetting('theme_mode', mode);
  }

  /// Get theme mode
  int getThemeMode() {
    return getSetting<int>('theme_mode', defaultValue: 0) ?? 0;
  }

  // ============ Locale Storage ============

  /// Save locale
  Future<void> saveLocale(String locale) async {
    await saveSetting('locale', locale);
  }

  /// Get locale
  String getLocale() {
    return getSetting<String>('locale', defaultValue: 'en') ?? 'en';
  }

  // ============ First Launch ============

  /// Check if first launch
  bool get isFirstLaunch {
    return getSetting<bool>('first_launch', defaultValue: true) ?? true;
  }

  /// Set first launch completed
  Future<void> setFirstLaunchCompleted() async {
    await saveSetting('first_launch', false);
  }
}
