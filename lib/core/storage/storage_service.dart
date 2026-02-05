import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

class StorageService {
  final Box _settingsBox;
  final Box _cacheBox;

  StorageService({required Box settingsBox, required Box cacheBox})
    : _settingsBox = settingsBox,
      _cacheBox = cacheBox;

  // ============ Settings Storage ============

  Future<void> saveSetting<T>(String key, T value) async {
    await _settingsBox.put(key, value);
  }

  T? getSetting<T>(String key, {T? defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  Future<void> removeSetting(String key) async {
    await _settingsBox.delete(key);
  }

  Future<void> clearSettings() async {
    await _settingsBox.clear();
  }

  // ============ Cache Storage ============

  Future<void> saveCache<T>(String key, T value, {Duration? expiry}) async {
    final cacheData = {
      'data': value,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'expiry': expiry?.inMilliseconds,
    };
    await _cacheBox.put(key, cacheData);
  }

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

  Future<void> removeCache(String key) async {
    await _cacheBox.delete(key);
  }

  Future<void> clearCache() async {
    await _cacheBox.clear();
  }

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

  Future<void> saveAuthToken(String token) async {
    await saveSetting(AppConstants.tokenKey, token);
  }

  String? getAuthToken() {
    return getSetting<String>(AppConstants.tokenKey);
  }

  Future<void> removeAuthToken() async {
    await removeSetting(AppConstants.tokenKey);
  }

  bool get isLoggedIn => getAuthToken() != null;

  // ============ Theme Mode Storage ============

  Future<void> saveThemeMode(int mode) async {
    await saveSetting('theme_mode', mode);
  }

  int getThemeMode() {
    return getSetting<int>('theme_mode', defaultValue: 0) ?? 0;
  }

  // ============ Locale Storage ============

  Future<void> saveLocale(String locale) async {
    await saveSetting('locale', locale);
  }

  String getLocale() {
    return getSetting<String>('locale', defaultValue: 'en') ?? 'en';
  }

  // ============ First Launch ============

  bool get isFirstLaunch {
    return getSetting<bool>('first_launch', defaultValue: true) ?? true;
  }

  Future<void> setFirstLaunchCompleted() async {
    await saveSetting('first_launch', false);
  }
}
