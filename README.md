# Mobile Template 🚀

[![CI/CD](https://github.com/YOUR_USERNAME/mobile_template/workflows/CI%2FCD/badge.svg)](https://github.com/YOUR_USERNAME/mobile_template/actions)
[![codecov](https://codecov.io/gh/YOUR_USERNAME/mobile_template/branch/main/graph/badge.svg)](https://codecov.io/gh/YOUR_USERNAME/mobile_template)
[![Flutter](https://img.shields.io/badge/Flutter-3.24-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A **production-ready** Flutter project template following **Clean Architecture** principles with Riverpod state management. Built with enterprise-grade features for scalable mobile applications.

## ✨ Features

### Architecture & Code Quality
- ✅ **Clean Architecture** - Data, Domain, Presentation layers
- ✅ **SOLID Principles** - Dependency inversion, single responsibility
- ✅ **Feature-first structure** - Scalable folder organization
- ✅ **Barrel exports** - Clean imports throughout

### State Management & DI
- ✅ **Riverpod** - Type-safe, compile-time verified state management
- ✅ **GetIt** - Service locator for dependency injection
- ✅ **Async State** - Pattern matching for loading/success/error states

### Navigation & Routing
- ✅ **GoRouter** - Declarative routing with deep linking
- ✅ **Auth guards** - Protected routes with automatic redirects
- ✅ **Named routes** - Type-safe navigation

### Networking
- ✅ **Dio** - HTTP client with interceptors
- ✅ **Connectivity monitoring** - Real network status
- ✅ **API response wrapper** - Standardized responses
- ✅ **Pagination support** - Built-in list pagination

### Storage & Security
- ✅ **Hive** - Fast local storage
- ✅ **Flutter Secure Storage** - Encrypted token storage
- ✅ **Storage service** - Cache with expiry support

### Error Handling
- ✅ **Either type (dartz)** - Functional error handling
- ✅ **Custom exceptions** - Server, network, cache errors
- ✅ **Custom failures** - Domain-level error types

### UI/UX
- ✅ **Material 3** - Modern design system
- ✅ **Dark/Light theme** - System-aware theming
- ✅ **Responsive utilities** - Mobile/tablet/desktop support
- ✅ **Shimmer loading** - Skeleton loading animations
- ✅ **Custom animations** - Page transitions, pulse, shake

### Developer Experience
- ✅ **Environment configs** - Dev/Staging/Production
- ✅ **Logger service** - Debug, info, warning, error levels
- ✅ **Performance monitoring** - Timer, frame, memory tracking
- ✅ **CI/CD pipeline** - GitHub Actions workflow
- ✅ **Comprehensive tests** - Unit, widget, integration

### Accessibility
- ✅ **Semantic widgets** - Screen reader support
- ✅ **Accessibility helpers** - Easy a11y implementation

### Analytics & Monitoring
- ✅ **Analytics service** - Ready for Firebase/Amplitude
- ✅ **Crash reporting** - Ready for Crashlytics/Sentry

## 📁 Architecture

```
lib/
├── main.dart                          # Dev entry point
├── main_staging.dart                  # Staging entry point
├── main_prod.dart                     # Production entry point
├── app/                               # App configuration
│   ├── app.dart                       # MaterialApp widget
│   ├── app_providers.dart             # Global providers
│   └── bootstrap.dart                 # App initialization
├── core/                              # Core utilities
│   ├── config/                        # Environment config
│   ├── constants/                     # App constants, dimensions
│   ├── di/                            # Dependency injection
│   ├── errors/                        # Exceptions & Failures
│   ├── network/                       # Dio client, API response
│   ├── router/                        # GoRouter config
│   ├── services/                      # Analytics, crash reporting
│   ├── state/                         # Async state classes
│   ├── storage/                       # Hive & secure storage
│   ├── theme/                         # App themes
│   ├── usecase/                       # Base use case interfaces
│   └── utils/                         # Validators, logger, etc.
├── features/                          # Feature modules
│   └── auth/                          # Auth feature example
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── pages/
│           ├── providers/
│           └── widgets/
└── shared/                            # Shared components
    └── widgets/                       # Reusable widgets
```

## 📦 Packages

| Category | Package | Purpose |
|----------|---------|---------|
| **State** | `flutter_riverpod` | State management |
| **DI** | `get_it` | Dependency injection |
| **Routing** | `go_router` | Navigation |
| **Network** | `dio` | HTTP client |
| **Functional** | `dartz` | Either type |
| **Storage** | `hive`, `hive_flutter` | Local database |
| **Security** | `flutter_secure_storage` | Encrypted storage |
| **JSON** | `json_annotation`, `json_serializable` | Serialization |
| **Network** | `connectivity_plus` | Connectivity |
| **Image** | `cached_network_image` | Image caching |
| **UI** | `shimmer` | Loading skeletons |
| **i18n** | `intl` | Internationalization |
| **Testing** | `mocktail` | Mocking |

## 🚀 Getting Started

### 1. Clone & Install

```bash
git clone https://github.com/YOUR_USERNAME/mobile_template.git
cd mobile_template
flutter pub get
```

### 2. Configure Environment

Edit `lib/core/config/env_config.dart`:

```dart
static const EnvConfig dev = EnvConfig._(
  environment: Environment.dev,
  apiBaseUrl: 'https://dev-api.yourapp.com',
  enableLogging: true,
  enableCrashReporting: false,
);
```

### 3. Run the App

```bash
# Development
flutter run

# Staging
flutter run -t lib/main_staging.dart

# Production
flutter run -t lib/main_prod.dart
```

### 4. Run Tests

```bash
# All tests
flutter test

# With coverage
flutter test --coverage

# Specific test
flutter test test/features/auth/domain/usecases/login_usecase_test.dart
```

## 🏗️ Creating a New Feature

### 1. Create folder structure

```bash
mkdir -p lib/features/your_feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
```

### 2. Follow the pattern

1. **Domain Layer** (no dependencies)
   - `entities/` - Business entities
   - `repositories/` - Abstract interfaces
   - `usecases/` - Single-action use cases

2. **Data Layer**
   - `models/` - `@JsonSerializable` models
   - `datasources/` - Remote/local data sources
   - `repositories/` - Implementations

3. **Presentation Layer**
   - `providers/` - Riverpod state
   - `pages/` - Screens
   - `widgets/` - Feature widgets

### 3. Register dependencies

```dart
// In core/di/injection_container.dart
Future<void> _initYourFeature() async {
  sl.registerLazySingleton<YourRemoteDataSource>(
    () => YourRemoteDataSourceImpl(networkClient: sl()),
  );
  sl.registerLazySingleton<YourRepository>(
    () => YourRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => YourUseCase(sl()));
}
```

### 4. Add routes

```dart
// In core/router/app_router.dart
GoRoute(
  path: '/your-route',
  name: 'your-route',
  builder: (context, state) => const YourPage(),
),
```

## 🧪 Testing

### Unit Tests
```dart
// test/features/auth/domain/usecases/login_usecase_test.dart
test('should return UserEntity when login successful', () async {
  when(() => mockRepository.login(email: any, password: any))
    .thenAnswer((_) async => const Right(tUser));
  
  final result = await useCase(LoginParams(...));
  
  expect(result, const Right(tUser));
});
```

### Widget Tests
```dart
testWidgets('should display button text', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: AppButton(text: 'Test', onPressed: () {}),
  ));
  expect(find.text('Test'), findsOneWidget);
});
```

## 📊 Utilities

### Logger
```dart
AppLogger.d('Debug message');
AppLogger.i('Info message', tag: 'AUTH');
AppLogger.e('Error', error: exception, stackTrace: stack);
```

### Dialogs & Snackbars
```dart
final confirmed = await AppDialogs.showConfirmation(context, title: 'Delete?', message: 'Are you sure?');
AppSnackbars.showSuccess(context, 'Saved!');
```

### Performance Monitoring
```dart
PerformanceMonitor.startTimer('api_call');
await apiCall();
PerformanceMonitor.stopTimer('api_call');
```

### Accessibility
```dart
Text('Hello').withSemanticLabel('Greeting text');
button.asButton(label: 'Submit form');
```

## 🔐 Security

- Tokens stored in `FlutterSecureStorage`
- Encrypted shared preferences on Android
- Keychain on iOS
- No sensitive data in logs (production)

## 📱 CI/CD

GitHub Actions workflow includes:
- ✅ Code formatting check
- ✅ Static analysis
- ✅ Unit & widget tests
- ✅ Coverage reporting
- ✅ Android APK/AAB build
- ✅ iOS build (no codesign)

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

**Built with ❤️ for scalable Flutter applications**
