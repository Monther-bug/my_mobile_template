import 'dart:convert';

import 'package:hive/hive.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';
import 'auth_local_datasource.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box box;

  AuthLocalDataSourceImpl({required this.box});

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = box.get(AppConstants.userKey);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await box.put(AppConstants.userKey, json.encode(user.toJson()));
  }

  @override
  Future<String?> getToken() async {
    return box.get(AppConstants.tokenKey);
  }

  @override
  Future<void> cacheToken(String token) async {
    await box.put(AppConstants.tokenKey, token);
  }

  @override
  Future<void> clearCache() async {
    await box.delete(AppConstants.userKey);
    await box.delete(AppConstants.tokenKey);
  }

  @override
  Future<bool> hasUser() async {
    return box.containsKey(AppConstants.userKey);
  }
}
