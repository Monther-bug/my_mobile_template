import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

/// User model with JSON serialization
/// Uses composition instead of inheritance since UserEntity uses Freezed
@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert to domain entity
  UserEntity toEntity() => UserEntity(
    id: id,
    email: email,
    name: name,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
  );

  /// Create from domain entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
    );
  }
}
