import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_template/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.loading() = AuthLoading;

  const factory AuthState.authenticated({
    required UserEntity user,
    required String accessToken,
    String? refreshToken,
  }) = AuthAuthenticated;

  const factory AuthState.unauthenticated({String? message}) =
      AuthUnauthenticated;

  const factory AuthState.error({required String message, Object? error}) =
      AuthError;
}

extension AuthStateX on AuthState {
  bool get isAuthenticated => this is AuthAuthenticated;

  bool get isLoading => this is AuthLoading;

  bool get hasError => this is AuthError;

  UserEntity? get currentUser =>
      mapOrNull(authenticated: (state) => state.user);

  String? get accessToken =>
      mapOrNull(authenticated: (state) => state.accessToken);

  String? get errorMessage =>
      maybeWhen(error: (message, _) => message, orElse: () => null);
}
