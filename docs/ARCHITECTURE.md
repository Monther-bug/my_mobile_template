# Mobile Template Architecture

## Overview

This template implements **Clean Architecture** with feature-based organization, designed for scalability, testability, and maintainability. It follows SOLID principles and leverages modern Flutter best practices.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────────────┐
│                        Presentation Layer                        │
│  (Pages, Widgets, Providers, Controllers)                        │
├─────────────────────────────────────────────────────────────────┤
│                         Domain Layer                             │
│  (Entities, Use Cases, Repository Interfaces)                   │
├─────────────────────────────────────────────────────────────────┤
│                          Data Layer                              │
│  (Models, Repository Implementations, Data Sources)             │
├─────────────────────────────────────────────────────────────────┤
│                          Core Layer                              │
│  (DI, Network, Router, Utils, Config, Services)                  │
└─────────────────────────────────────────────────────────────────┘
```

### Layer Dependencies

```
Presentation → Domain ← Data
     ↓           ↓        ↓
         ←─── Core ────→
```

**Key Principle**: Inner layers don't know about outer layers. Domain defines interfaces, Data implements them.

## Folder Structure

```
lib/
├── main.dart              # Entry point
├── app.dart               # App widget configuration
├── bootstrap.dart         # Initialization logic
├── core/                  # Shared infrastructure
│   ├── config/            # Environment & feature flags
│   ├── constants/         # App-wide constants
│   ├── data/              # Base repositories & caching
│   ├── di/                # Dependency injection
│   ├── error/             # Error types (Freezed)
│   ├── errors/            # Exception & failure classes
│   ├── extensions/        # Dart extensions
│   ├── l10n/              # Localization
│   ├── network/           # HTTP client & interceptors
│   ├── router/            # GoRouter configuration
│   ├── services/          # Cross-cutting services
│   ├── theme/             # Theme configuration
│   ├── types/             # Generic types (Result)
│   ├── usecase/           # Base use case classes
│   └── utils/             # Utility functions
├── features/              # Feature modules
│   └── auth/              # Authentication feature
│       ├── data/          # Data layer
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/        # Domain layer
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/  # Presentation layer
│           ├── pages/
│           ├── providers/
│           └── widgets/
└── shared/                # Shared UI components
    └── widgets/
```

## Key Design Patterns

### 1. Repository Pattern
```dart
// Domain layer - Interface
abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({...});
}

// Data layer - Implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  
  @override
  Future<Either<Failure, UserEntity>> login({...}) async {
    // Implementation with data sources
  }
}
```

### 2. Use Case Pattern
```dart
class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
```

### 3. Freezed for Immutable Models
```dart
@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String email,
    String? name,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
```

### 4. Sealed Classes for State Management
```dart
@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated({required UserEntity user}) = AuthAuthenticated;
  const factory AuthState.unauthenticated() = AuthUnauthenticated;
  const factory AuthState.error({required String message}) = AuthError;
}
```

### 5. Either Type for Error Handling
```dart
Future<Either<Failure, UserEntity>> login() async {
  try {
    final user = await remoteDataSource.login();
    return Right(user.toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(message: e.message));
  }
}
```

## Dependency Injection

Using **GetIt** with service locator pattern:

```dart
final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<NetworkClient>(() => NetworkClient(dio: Dio()));
  
  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl()));
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));
  
  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(repository: sl()));
}
```

## State Management

Using **Riverpod** with `StateNotifier`:

```dart
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    loginUseCase: ref.read(loginUseCaseProvider),
  );
});

class AuthController extends StateNotifier<AuthState> {
  AuthController({required this.loginUseCase}) : super(const AuthState.initial());

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    final result = await loginUseCase(LoginParams(email: email, password: password));
    state = result.fold(
      (failure) => AuthState.error(message: failure.message),
      (user) => AuthState.authenticated(user: user),
    );
  }
}
```

## Routing

Using **GoRouter** with authentication guards:

```dart
final router = GoRouter(
  initialLocation: AppRoutes.splash,
  redirect: (context, state) {
    final isAuthenticated = /* check auth */;
    final isAuthRoute = state.matchedLocation.startsWith('/auth');
    
    if (!isAuthenticated && !isAuthRoute) {
      return AppRoutes.login;
    }
    if (isAuthenticated && isAuthRoute) {
      return AppRoutes.home;
    }
    return null;
  },
  routes: [/* route definitions */],
);
```

## Testing Strategy

### Unit Tests
- Use Cases
- Repositories
- Validators
- Utils

### Widget Tests
- Individual widgets
- Pages (with mocked providers)

### Integration Tests
- Full user flows
- Navigation testing

### Mocking with Mocktail
```dart
class MockAuthRepository extends Mock implements AuthRepository {}

test('should return user on successful login', () async {
  when(() => mockRepository.login(email: any(named: 'email'), password: any(named: 'password')))
      .thenAnswer((_) async => Right(testUser));
  
  final result = await loginUseCase(LoginParams(email: 'test@test.com', password: 'password'));
  
  expect(result, Right(testUser));
});
```

## Code Generation

Run after modifying Freezed/JSON models:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch mode for development:
```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Feature Flags

```dart
class FeatureFlagService {
  Future<bool> isFeatureEnabled(String featureKey) async {
    // Check remote config, then local defaults
  }
  
  Future<T> getFeatureValue<T>(String featureKey, T defaultValue) async {
    // Get feature configuration value
  }
}
```

## Caching Strategy

```dart
enum CachePolicy {
  cacheFirst,     // Return cached, fetch in background
  networkFirst,   // Try network, fallback to cache
  cacheOnly,      // Only return cached data
  networkOnly,    // Only fetch from network
  staleWhileRevalidate,  // Return cached, update from network
}
```

## Error Handling

Unified error types with Freezed sealed classes:

```dart
@freezed
sealed class AppFailure with _$AppFailure {
  const factory AppFailure.server({required String message, int? statusCode}) = ServerFailure;
  const factory AppFailure.network() = NetworkFailure;
  const factory AppFailure.cache() = CacheFailure;
  const factory AppFailure.authentication() = AuthenticationFailure;
  const factory AppFailure.validation({Map<String, List<String>>? fieldErrors}) = ValidationFailure;
}
```

## Environment Configuration

```dart
enum Environment { development, staging, production }

class EnvironmentConfig {
  static late Environment _environment;
  static late String _baseUrl;
  
  static void init(Environment env) {
    _environment = env;
    _baseUrl = switch (env) {
      Environment.development => 'https://dev-api.example.com',
      Environment.staging => 'https://staging-api.example.com',
      Environment.production => 'https://api.example.com',
    };
  }
}
```

## Localization

Multi-language support with intl:

```dart
class AppLocalizations {
  static const supportedLocales = [Locale('en'), Locale('ar')];
  
  String get appTitle => _translate('app_title');
  String get login => _translate('login');
  String get email => _translate('email');
  // ...
}
```

## CI/CD Pipeline

GitHub Actions workflow for:
- Code analysis (`flutter analyze`)
- Unit tests (`flutter test`)
- Integration tests
- Build artifacts (APK, IPA)

## Best Practices

1. **Single Responsibility**: Each class has one reason to change
2. **Dependency Inversion**: Depend on abstractions, not concretions
3. **Interface Segregation**: Small, focused interfaces
4. **Open/Closed**: Open for extension, closed for modification
5. **Immutability**: Use `const` constructors and Freezed
6. **Error Handling**: Use Either type for explicit error handling
7. **Testing**: Write tests for business logic
8. **Documentation**: Document public APIs

## Adding a New Feature

1. Create feature folder under `lib/features/`
2. Add domain layer (entities, repository interface, use cases)
3. Add data layer (models, data sources, repository implementation)
4. Add presentation layer (pages, providers, widgets)
5. Register dependencies in `injection_container.dart`
6. Add routes in `app_router.dart`
7. Write tests for each layer

## Performance Considerations

- Use `const` constructors where possible
- Implement `shouldRebuild` in RepaintBoundary
- Use `ListView.builder` for long lists
- Implement pagination for large datasets
- Cache network responses appropriately
- Use image caching (cached_network_image)
