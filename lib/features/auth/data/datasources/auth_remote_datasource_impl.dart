import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/network_client.dart';
import '../models/user_model.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkClient networkClient;

  AuthRemoteDataSourceImpl({required this.networkClient});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await networkClient.post(
      ApiEndpoints.login,
      data: {'email': email, 'password': password},
    );

    final token = response.data['token'] as String?;
    if (token != null) {
      networkClient.setAuthToken(token);
    }

    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final response = await networkClient.post(
      ApiEndpoints.register,
      data: <String, dynamic>{
        'email': email,
        'password': password,
        if (name != null) 'name': name,
      },
    );

    final token = response.data['token'] as String?;
    if (token != null) {
      networkClient.setAuthToken(token);
    }

    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<void> logout() async {
    await networkClient.post(ApiEndpoints.logout);
    networkClient.clearAuthToken();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final response = await networkClient.get(ApiEndpoints.userProfile);
    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<void> refreshToken() async {
    final response = await networkClient.post(ApiEndpoints.refreshToken);
    final token = response.data['token'] as String?;
    if (token != null) {
      networkClient.setAuthToken(token);
    }
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await networkClient.post('/auth/forgot-password', data: {'email': email});
  }
}
