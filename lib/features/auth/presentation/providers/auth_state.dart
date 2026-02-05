import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_template/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

/// Authentication state union type using Freezed
/// Enables exhaustive pattern matching and type-safe state handling
@freezed
sealed class AuthState with _$AuthState {
  /// Initial state - not yet determined
  const factory AuthState.initial() = AuthInitial;

  /// Loading/checking authentication status
  const factory AuthState.loading() = AuthLoading;

  /// User is authenticated
  const factory AuthState.authenticated({
    required UserEntity user,
    required String accessToken,
    String? refreshToken,
  }) = AuthAuthenticated;

  /// User is not authenticated
  const factory AuthState.unauthenticated({String? message}) =
      AuthUnauthenticated;

  /// Authentication error occurred
  const factory AuthState.error({required String message, Object? error}) =
      AuthError;
}

/// Extension methods for AuthState
extension AuthStateX on AuthState {
  /// Check if user is currently authenticated
  bool get isAuthenticated => this is AuthAuthenticated;

  /// Check if authentication is being processed
  bool get isLoading => this is AuthLoading;

  /// Check if there was an error
  bool get hasError => this is AuthError;

  /// Get the current user if authenticated
  UserEntity? get currentUser =>
      mapOrNull(authenticated: (state) => state.user);

  /// Get the access token if authenticated
  String? get accessToken =>
      mapOrNull(authenticated: (state) => state.accessToken);

  /// Get error message if in error state
  String? get errorMessage =>
      maybeWhen(error: (message, _) => message, orElse: () => null);
}
