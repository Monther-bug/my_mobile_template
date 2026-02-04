import '../models/user_model.dart';

/// Remote data source for authentication
abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<UserModel> login({required String email, required String password});

  /// Register new user
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  });

  /// Logout
  Future<void> logout();

  /// Get current user from server
  Future<UserModel> getCurrentUser();

  /// Refresh token
  Future<void> refreshToken();

  /// Request password reset
  Future<void> requestPasswordReset(String email);
}
