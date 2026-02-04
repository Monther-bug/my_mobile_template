import '../models/user_model.dart';

/// Local data source for authentication (caching)
abstract class AuthLocalDataSource {
  /// Get cached user
  Future<UserModel?> getCachedUser();

  /// Cache user
  Future<void> cacheUser(UserModel user);

  /// Get cached token
  Future<String?> getToken();

  /// Cache token
  Future<void> cacheToken(String token);

  /// Clear all auth cache
  Future<void> clearCache();

  /// Check if user is cached
  Future<bool> hasUser();
}
