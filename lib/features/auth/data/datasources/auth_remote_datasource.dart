import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  /// Register new user
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  });

  Future<void> logout();

  Future<UserModel> getCurrentUser();

  Future<void> refreshToken();

  Future<void> requestPasswordReset(String email);
}
