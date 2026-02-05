# Mobile Template

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.5+-blue.svg)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Style: Very Good Analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A **production-ready** Flutter project template following **Clean Architecture** principles with Riverpod state management. Built with enterprise-grade features for scalable mobile applications.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Development](#development)
- [Testing](#testing)
- [Packages](#packages)
- [Documentation](#documentation)
- [Author](#author)
- [License](#license)

## Features

### Architecture & Code Quality
- **Clean Architecture** - Data, Domain, Presentation layers with clear separation
- **SOLID Principles** - Dependency inversion, single responsibility, interface segregation
- **Feature-first structure** - Scalable modular organization
- **Freezed models** - Immutable data classes with code generation
- **Barrel exports** - Clean and organized imports

### State Management & DI
- **Riverpod** - Type-safe, compile-time verified state management
- **GetIt** - Service locator for dependency injection
- **Async State** - Pattern matching for loading/success/error states
- **StateNotifier** - Reactive state management with immutable states

### Navigation & Routing
- **GoRouter** - Declarative routing with deep linking support
- **Auth guards** - Protected routes with automatic redirects
- **Named routes** - Type-safe navigation constants
- **Error pages** - Graceful handling of navigation errors

### Networking
- **Dio** - Powerful HTTP client with interceptors
- **Retry logic** - Automatic retry with exponential backoff
- **Logging interceptor** - Detailed request/response logging
- **Performance tracking** - API call timing and slow request detection
- **API response wrapper** - Standardized response handling
- **Pagination support** - Built-in infinite scroll pagination

### Storage & Security
- **Hive** - Fast NoSQL local storage
- **Flutter Secure Storage** - Encrypted token storage
- **Cache with expiry** - Automatic cache invalidation
- **Multiple cache policies** - Network-first, cache-first, stale-while-revalidate

### Error Handling
- **Either type (dartz)** - Functional error handling
- **Freezed failures** - Type-safe error types with pattern matching
- **Custom exceptions** - Server, network, cache, validation errors
- **Graceful degradation** - Fallback strategies for failures

### UI/UX Components
- **Material 3** - Modern Material Design system
- **Dark/Light theme** - System-aware theming with manual toggle
- **Responsive utilities** - Mobile/tablet/desktop breakpoints
- **Shimmer loading** - Skeleton loading animations
- **Custom animations** - Fade, slide, scale page transitions
- **Form widgets** - Text fields, dropdowns, checkboxes, switches
- **Common widgets** - Buttons, cards, avatars, badges, empty states

### Developer Experience
- **Environment configs** - Dev/Staging/Production configurations
- **Feature flags** - Runtime feature toggling
- **Logger service** - Colored debug logs with tags
- **Performance monitoring** - Timer tracking and memory monitoring
- **Code generation** - Freezed, JSON serializable with build_runner

### Accessibility
- **Semantic widgets** - Screen reader support
- **Accessibility helpers** - Easy a11y implementation
- **Focus management** - Proper keyboard navigation

### Services
- **Analytics service** - Ready for Firebase/Amplitude integration
- **Crash reporting** - Ready for Crashlytics/Sentry integration
- **App update service** - Version checking and force update support

## Architecture

This template implements **Clean Architecture** with three main layers:

```
+------------------------------------------------------------------+
|                      PRESENTATION LAYER                           |
|          (Pages, Widgets, Providers, Controllers)                 |
|                                                                   |
|   - UI components and screens                                     |
|   - State management (Riverpod)                                   |
|   - User interaction handling                                     |
+------------------------------------------------------------------+
|                        DOMAIN LAYER                               |
|        (Entities, Use Cases, Repository Interfaces)               |
|                                                                   |
|   - Business logic and rules                                      |
|   - Platform-independent                                          |
|   - No external dependencies                                      |
+------------------------------------------------------------------+
|                         DATA LAYER                                |
|     (Models, Repository Implementations, Data Sources)            |
|                                                                   |
|   - API integration                                               |
|   - Local storage                                                 |
|   - Data transformation                                           |
+------------------------------------------------------------------+
|                         CORE LAYER                                |
|       (DI, Network, Router, Utils, Config, Services)              |
|                                                                   |
|   - Shared infrastructure                                         |
|   - Cross-cutting concerns                                        |
|   - Configuration and utilities                                   |
+------------------------------------------------------------------+
```

### Dependency Flow

```
Presentation --> Domain <-- Data
      |            |          |
      +-------- Core ---------+
```

**Key Principle**: Inner layers don't know about outer layers. Domain defines interfaces, Data implements them.

## Project Structure

```
lib/
|-- main.dart                    # Development entry point
|-- main_staging.dart            # Staging entry point
|-- main_prod.dart               # Production entry point
|
|-- app/                         # App configuration
|   |-- app.dart                 # MaterialApp widget
|   |-- app_providers.dart       # Global Riverpod providers
|   |-- app.exports.dart         # App barrel exports
|   +-- bootstrap.dart           # App initialization
|
|-- core/                        # Core utilities & infrastructure
|   |-- config/                  # Environment & feature flags
|   |-- constants/               # App constants
|   |-- data/                    # Base data utilities
|   |-- di/                      # Dependency injection
|   |-- error/                   # Freezed error types
|   |-- errors/                  # Exception & failure classes
|   |-- l10n/                    # Localization
|   |-- network/                 # HTTP client & API
|   |-- router/                  # Navigation
|   |-- services/                # Cross-cutting services
|   |-- state/                   # State utilities
|   |-- storage/                 # Local storage
|   |-- theme/                   # Theming
|   |-- types/                   # Generic types
|   |-- usecase/                 # Base use case
|   +-- utils/                   # Utilities
|
|-- features/                    # Feature modules
|   +-- auth/                    # Authentication feature
|       |-- data/
|       |   |-- datasources/
|       |   |-- models/
|       |   +-- repositories/
|       |-- domain/
|       |   |-- entities/
|       |   |-- repositories/
|       |   +-- usecases/
|       +-- presentation/
|           |-- pages/
|           +-- providers/
|
+-- shared/                      # Shared UI components
    +-- widgets/
```

## Getting Started

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart SDK 3.5.0 or higher
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)

### Installation

1. **Clone the repository**

```bash
git clone https://github.com/Monther-bug/mobile_template.git
cd mobile_template
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run code generation**

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Run the app**

```bash
# Development
flutter run

# Staging
flutter run -t lib/main_staging.dart

# Production
flutter run -t lib/main_prod.dart
```

## Configuration

### Environment Configuration

Edit `lib/core/config/env_config.dart`:

```dart
static const EnvConfig dev = EnvConfig._(
  environment: Environment.dev,
  apiBaseUrl: 'https://dev-api.yourapp.com',
  enableLogging: true,
  enableCrashReporting: false,
);

static const EnvConfig staging = EnvConfig._(
  environment: Environment.staging,
  apiBaseUrl: 'https://staging-api.yourapp.com',
  enableLogging: true,
  enableCrashReporting: true,
);

static const EnvConfig prod = EnvConfig._(
  environment: Environment.prod,
  apiBaseUrl: 'https://api.yourapp.com',
  enableLogging: false,
  enableCrashReporting: true,
);
```

### Feature Flags

Edit `lib/core/config/feature_flags.dart`:

```dart
class FeatureFlags {
  static bool enableNewOnboarding = false;
  static bool enableDarkMode = true;
  static bool enableBiometricAuth = true;
}
```

## Development

### Creating a New Feature

1. **Create folder structure**

```bash
mkdir -p lib/features/your_feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
```

2. **Domain Layer** (define first - no dependencies)

```dart
// entities/product_entity.dart
class ProductEntity {
  final String id;
  final String name;
  final double price;
}

// repositories/product_repository.dart
abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}

// usecases/get_products_usecase.dart
class GetProductsUseCase implements UseCaseNoParams<List<ProductEntity>> {
  final ProductRepository repository;
  GetProductsUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getProducts();
  }
}
```

3. **Data Layer** (implement domain interfaces)

```dart
// models/product_model.dart
@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final double price;
  
  ProductEntity toEntity() => ProductEntity(id: id, name: name, price: price);
}

// repositories/product_repository_impl.dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  
  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final models = await remoteDataSource.getProducts();
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
```

4. **Presentation Layer** (UI and state)

```dart
// providers/products_provider.dart
final productsProvider = FutureProvider<List<ProductEntity>>((ref) async {
  final useCase = ref.read(getProductsUseCaseProvider);
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
});

// pages/products_page.dart
class ProductsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    return productsAsync.when(
      data: (products) => ProductsList(products: products),
      loading: () => const LoadingWidget(),
      error: (e, _) => AppErrorWidget(message: e.toString()),
    );
  }
}
```

5. **Register dependencies** in `lib/core/di/injection_container.dart`

```dart
Future<void> _initProducts() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
}
```

6. **Add routes** in `lib/core/router/app_router.dart`

```dart
GoRoute(
  path: AppRoutes.products,
  name: 'products',
  builder: (context, state) => const ProductsPage(),
),
```

### Code Generation

After modifying Freezed or JSON serializable models:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (recommended during development)
dart run build_runner watch --delete-conflicting-outputs
```

### Utilities

**Logger**

```dart
AppLogger.d('Debug message');
AppLogger.i('Info message', tag: 'AUTH');
AppLogger.w('Warning message');
AppLogger.e('Error', error: exception, stackTrace: stack);
```

**Dialogs & Snackbars**

```dart
final confirmed = await AppDialogs.showConfirmation(
  context,
  title: 'Delete?',
  message: 'Are you sure?',
);

AppSnackbars.showSuccess(context, 'Saved successfully!');
AppSnackbars.showError(context, 'Something went wrong');
```

**Validators**

```dart
Validators.validateEmail('user@example.com');
Validators.validatePassword('password123');
Validators.validateRequired('value', fieldName: 'Name');
```

**Date Utilities**

```dart
DateTimeUtils.formatDate(DateTime.now());
DateTimeUtils.getRelativeTime(someDate);
DateTimeUtils.isToday(someDate);
```

## Testing

### Run Tests

```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test file
flutter test test/features/auth/domain/usecases/login_usecase_test.dart

# Integration tests
flutter test integration_test/
```

### Test Structure

```
test/
|-- core/
|   |-- utils/
|   +-- network/
|-- features/
|   +-- auth/
|       |-- domain/
|       |-- data/
|       +-- presentation/
+-- shared/
    +-- widgets/
```

### Example Test

```dart
void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase useCase;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    test('should return UserEntity when login is successful', () async {
      // Arrange
      when(() => mockRepository.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      )).thenAnswer((_) async => Right(tUser));

      // Act
      final result = await useCase(LoginParams(
        email: 'test@test.com',
        password: 'password123',
      ));

      // Assert
      expect(result, Right(tUser));
    });
  });
}
```

## Packages

| Category | Package | Purpose |
|----------|---------|---------|
| **State** | `flutter_riverpod` | State management |
| **DI** | `get_it` | Dependency injection |
| **Routing** | `go_router` | Navigation |
| **Network** | `dio` | HTTP client |
| **Functional** | `dartz` | Either type, functional utils |
| **Code Gen** | `freezed` | Immutable classes |
| **JSON** | `json_serializable` | JSON serialization |
| **Storage** | `hive_flutter` | Local database |
| **Security** | `flutter_secure_storage` | Encrypted storage |
| **Connectivity** | `connectivity_plus` | Network status |
| **Image** | `cached_network_image` | Image caching |
| **UI** | `shimmer` | Loading skeletons |
| **i18n** | `intl` | Internationalization |
| **Info** | `package_info_plus` | App version info |
| **Testing** | `mocktail` | Mocking |

## Documentation

- [Architecture Guide](docs/ARCHITECTURE.md) - Detailed architecture documentation
- [API Documentation](docs/API.md) - API endpoints and integration guide
- [Contributing Guide](docs/CONTRIBUTING.md) - How to contribute to this project

## Security

- Tokens stored in `FlutterSecureStorage` with encryption
- Android: EncryptedSharedPreferences
- iOS: Keychain with first unlock accessibility
- No sensitive data logged in production
- Secure HTTP headers and certificate pinning ready

## Supported Platforms

- Android (API 21+)
- iOS (12.0+)
- Web (experimental)
- macOS (experimental)
- Windows (experimental)
- Linux (experimental)

## Author

**Monther Ibrahim**

- GitHub: [@Monther-bug](https://github.com/Monther-bug)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Built with love for scalable Flutter applications**
