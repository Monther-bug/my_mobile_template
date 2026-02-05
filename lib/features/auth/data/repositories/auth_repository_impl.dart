import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final user = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );
      await localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on ValidationException catch (e) {
      return Left(
        ValidationFailure(message: e.message, fieldErrors: e.fieldErrors),
      );
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
      return const Right(null);
    } catch (e) {
      // Even if remote logout fails, clear local cache
      await localDataSource.clearCache();
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      // First try to get from cache
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) {
        // Optionally refresh from server in background
        _refreshUserInBackground();
        return Right(cachedUser.toEntity());
      }

      // If no cache, try to get from server
      final user = await remoteDataSource.getCurrentUser();
      await localDataSource.cacheUser(user);
      return Right(user.toEntity());
    } on AuthException {
      return const Right(null);
    } on NetworkException {
      // Return cached user if available during network issues
      final cachedUser = await localDataSource.getCachedUser();
      return Right(cachedUser?.toEntity());
    } catch (e) {
      return const Right(null);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    return await localDataSource.hasUser();
  }

  @override
  Future<Either<Failure, void>> refreshToken() async {
    try {
      await remoteDataSource.refreshToken();
      return const Right(null);
    } on AuthException catch (e) {
      await localDataSource.clearCache();
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset(String email) async {
    try {
      await remoteDataSource.requestPasswordReset(email);
      return const Right(null);
    } on NetworkException {
      return const Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  /// Refresh user data in background
  Future<void> _refreshUserInBackground() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      await localDataSource.cacheUser(user);
    } catch (_) {
      // Silently fail background refresh
    }
  }
}
