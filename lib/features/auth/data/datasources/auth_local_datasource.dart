import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getCachedUser();

  Future<void> cacheUser(UserModel user);

  Future<String?> getToken();

  Future<void> cacheToken(String token);

  Future<void> clearCache();

  Future<bool> hasUser();
}
