# Contributing Guide

Thank you for considering contributing to this Flutter template! This document provides guidelines and best practices for contributing.

## Development Setup

### Prerequisites
- Flutter SDK ^3.10.4
- Dart SDK ^3.10.4
- IDE: VS Code or Android Studio with Flutter plugin

### Getting Started
```bash
# Clone the repository
git clone <repository-url>
cd mobile_template

# Install dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs

# Run tests
flutter test

# Run the app
flutter run
```

## Code Style

### Dart Style Guide
Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style) and [Flutter Style Guide](https://flutter.dev/docs/development/quality-assurance/style-guide).

### Formatting
```bash
# Format all Dart files
dart format lib test

# Or use the Dart VS Code extension format on save
```

### Analysis
```bash
# Run static analysis
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Linting
We use `flutter_lints` with custom rules defined in `analysis_options.yaml`.

## Architecture Guidelines

### Layer Responsibilities

#### Presentation Layer
- Pages, Widgets, Providers
- UI logic only
- No business logic
- Depends on Domain layer

#### Domain Layer
- Entities (business objects)
- Use Cases (business logic)
- Repository Interfaces
- No dependencies on other layers

#### Data Layer
- Models (with serialization)
- Repository Implementations
- Data Sources (remote, local)
- Depends on Domain layer

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | snake_case | `user_entity.dart` |
| Classes | PascalCase | `UserEntity` |
| Variables | camelCase | `currentUser` |
| Constants | lowerCamelCase | `maxRetries` |
| Private members | _prefix | `_internalState` |

### File Organization

```dart
// 1. Imports (sorted)
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:third_party/package.dart';

import 'relative/import.dart';

// 2. Part directives (for generated code)
part 'file.g.dart';
part 'file.freezed.dart';

// 3. Constants and typedefs

// 4. Main class/widget

// 5. Supporting classes
```

## Git Workflow

### Branch Naming
- `feature/` - New features
- `bugfix/` - Bug fixes
- `hotfix/` - Critical fixes for production
- `refactor/` - Code refactoring
- `docs/` - Documentation changes

Examples:
- `feature/user-profile`
- `bugfix/login-validation`
- `refactor/auth-module`

### Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting (no code change)
- `refactor`: Refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:
```
feat(auth): add forgot password functionality
fix(login): validate email format before submission
docs(readme): update installation instructions
refactor(network): extract retry logic to separate class
test(auth): add unit tests for login use case
```

### Pull Request Process

1. Create feature branch from `main`
2. Make changes following coding standards
3. Write/update tests
4. Run `flutter analyze` and `flutter test`
5. Create PR with descriptive title and body
6. Address review comments
7. Squash and merge

### PR Checklist
- [ ] Code follows project style guide
- [ ] Tests added/updated
- [ ] `flutter analyze` passes
- [ ] `flutter test` passes
- [ ] Documentation updated if needed
- [ ] No merge conflicts

## Testing Guidelines

### Test File Location
```
lib/
  features/
    auth/
      domain/
        usecases/
          login_usecase.dart
test/
  features/
    auth/
      domain/
        usecases/
          login_usecase_test.dart
```

### Test Structure
```dart
void main() {
  // Declare dependencies
  late MockRepository mockRepository;
  late UseCase useCase;

  // Setup before each test
  setUp(() {
    mockRepository = MockRepository();
    useCase = UseCase(repository: mockRepository);
  });

  // Group related tests
  group('UseCase', () {
    test('should return success when repository succeeds', () async {
      // Arrange
      when(() => mockRepository.method()).thenReturn(expected);
      
      // Act
      final result = await useCase();
      
      // Assert
      expect(result, expected);
      verify(() => mockRepository.method()).called(1);
    });
  });
}
```

### Test Naming
- Describe what is being tested
- Describe the expected behavior
- Describe the conditions

```dart
test('login should return user when credentials are valid', () {});
test('login should return AuthFailure when credentials are invalid', () {});
test('getCurrentUser should return cached user when network is unavailable', () {});
```

### Mocking
Use `mocktail` for mocking:

```dart
class MockAuthRepository extends Mock implements AuthRepository {}

setUpAll(() {
  registerFallbackValue(FakeLoginParams());
});
```

## Adding a New Feature

### 1. Domain Layer First
```dart
// 1. Create entity
class ProductEntity {
  final String id;
  final String name;
  final double price;
  
  const ProductEntity({...});
}

// 2. Create repository interface
abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}

// 3. Create use case
class GetProductsUseCase implements UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository repository;
  
  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) {
    return repository.getProducts();
  }
}
```

### 2. Data Layer
```dart
// 1. Create model
@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final double price;
  
  ProductEntity toEntity() => ProductEntity(...);
  factory ProductModel.fromJson(Map<String, dynamic> json) => ...;
}

// 2. Create data source
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final NetworkClient client;
  
  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await client.get('/products');
    return (response.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}

// 3. Implement repository
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final models = await remoteDataSource.getProducts();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
```

### 3. Presentation Layer
```dart
// 1. Create provider
final productsProvider = FutureProvider<List<ProductEntity>>((ref) {
  return ref.read(getProductsUseCaseProvider)().then(
    (result) => result.fold(
      (failure) => throw Exception(failure.message),
      (products) => products,
    ),
  );
});

// 2. Create page
class ProductsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    
    return productsAsync.when(
      data: (products) => ProductsList(products: products),
      loading: () => const LoadingIndicator(),
      error: (e, _) => ErrorWidget(message: e.toString()),
    );
  }
}
```

### 4. Register Dependencies
```dart
// In injection_container.dart
sl.registerLazySingleton<ProductRemoteDataSource>(
  () => ProductRemoteDataSourceImpl(client: sl()),
);
sl.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(remoteDataSource: sl()),
);
sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
```

### 5. Add Routes
```dart
// In app_routes.dart
static const String products = '/products';

// In app_router.dart
GoRoute(
  path: AppRoutes.products,
  builder: (context, state) => const ProductsPage(),
),
```

### 6. Write Tests
```dart
// Domain layer tests
test('GetProductsUseCase should return products', () async {...});

// Data layer tests
test('ProductRepositoryImpl should return entities from data source', () async {...});

// Widget tests
testWidgets('ProductsPage shows loading then products', (tester) async {...});
```

## Documentation

### Code Documentation
```dart
/// A use case that handles user authentication.
///
/// This use case validates credentials and returns a [UserEntity]
/// on success or a [Failure] on error.
///
/// Example:
/// ```dart
/// final result = await loginUseCase(LoginParams(
///   email: 'user@example.com',
///   password: 'password123',
/// ));
/// ```
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  /// Creates a new [LoginUseCase] with the given [repository].
  LoginUseCase({required this.repository});

  /// The authentication repository.
  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {...}
}
```

### README Updates
Update README.md when adding:
- New features
- New dependencies
- Environment changes
- Setup steps

## Questions?

If you have questions about contributing, please:
1. Check existing documentation
2. Search for similar issues/PRs
3. Open a discussion or issue

Thank you for contributing! 🎉
