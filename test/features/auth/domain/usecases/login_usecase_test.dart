import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:mobile_template/core/errors/failures.dart';
import 'package:mobile_template/features/auth/domain/entities/user_entity.dart';
import 'package:mobile_template/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_template/features/auth/domain/usecases/login_usecase.dart';

// Mock classes
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tUser = UserEntity(
    id: '1',
    email: tEmail,
    name: 'Test User',
  );

  group('LoginUseCase', () {
    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => const Right(tUser));

      // Act
      final result = await useCase(
        const LoginParams(email: tEmail, password: tPassword),
      );

      // Assert
      expect(result, const Right(tUser));
      verify(() => mockRepository.login(
            email: tEmail,
            password: tPassword,
          )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return ServerFailure when login fails', () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Invalid credentials');
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(
        const LoginParams(email: tEmail, password: tPassword),
      );

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockRepository.login(
            email: tEmail,
            password: tPassword,
          )).called(1);
    });

    test('should return NetworkFailure when there is no internet', () async {
      // Arrange
      const tFailure = NetworkFailure(message: 'No internet connection');
      when(() => mockRepository.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await useCase(
        const LoginParams(email: tEmail, password: tPassword),
      );

      // Assert
      expect(result, const Left(tFailure));
    });
  });
}
