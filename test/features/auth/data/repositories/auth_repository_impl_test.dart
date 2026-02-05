import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:mobile_template/core/errors/exceptions.dart';
import 'package:mobile_template/core/errors/failures.dart';
import 'package:mobile_template/core/network/network_info.dart';
import 'package:mobile_template/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:mobile_template/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mobile_template/features/auth/data/models/user_model.dart';
import 'package:mobile_template/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_template/features/auth/domain/entities/user_entity.dart';

// Mock classes
class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUserModel = UserModel(id: '1', email: tEmail, name: 'Test User');
  const UserEntity tUser = tUserModel;

  group('login', () {
    test('should return user when remote call is successful', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => tUserModel);
      when(() => mockLocalDataSource.cacheUser(any())).thenAnswer((_) async {});

      // Act
      final result = await repository.login(email: tEmail, password: tPassword);

      // Assert
      expect(result, const Right(tUser));
      verify(
        () => mockRemoteDataSource.login(email: tEmail, password: tPassword),
      ).called(1);
      verify(() => mockLocalDataSource.cacheUser(tUserModel)).called(1);
    });

    test(
      'should return ServerFailure when remote call throws ServerException',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const ServerException(message: 'Server error'));

        // Act
        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<ServerFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );

    test(
      'should return NetworkFailure when remote call throws NetworkException',
      () async {
        // Arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(const NetworkException(message: 'No internet'));

        // Act
        final result = await repository.login(
          email: tEmail,
          password: tPassword,
        );

        // Assert
        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold(
          (failure) => expect(failure, isA<NetworkFailure>()),
          (_) => fail('Should return failure'),
        );
      },
    );
  });

  group('getCurrentUser', () {
    test('should return cached user when available', () async {
      // Arrange
      when(
        () => mockLocalDataSource.getCachedUser(),
      ).thenAnswer((_) async => tUserModel);

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      expect(result, const Right(tUser));
      verify(() => mockLocalDataSource.getCachedUser()).called(1);
    });

    test('should return CacheFailure when no cached user', () async {
      // Arrange
      when(
        () => mockLocalDataSource.getCachedUser(),
      ).thenThrow(const CacheException(message: 'No cached user'));

      // Act
      final result = await repository.getCurrentUser();

      // Assert
      expect(result, isA<Left<Failure, UserEntity>>());
    });
  });

  group('logout', () {
    test('should clear cached user on logout', () async {
      // Arrange
      when(() => mockLocalDataSource.clearCache()).thenAnswer((_) async {});

      // Act
      final result = await repository.logout();

      // Assert
      expect(result, const Right(null));
      verify(() => mockLocalDataSource.clearCache()).called(1);
    });
  });
}
