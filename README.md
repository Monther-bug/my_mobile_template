# Mobile Template

A production-ready Flutter project template following Clean Architecture principles with Riverpod state management.

## Features

- ✅ Clean Architecture (Data, Domain, Presentation layers)
- ✅ Riverpod for state management
- ✅ GoRouter for navigation with auth guards
- ✅ GetIt for dependency injection
- ✅ Dio for networking with interceptors
- ✅ Hive for local storage
- ✅ Complete auth flow (login, register, logout)
- ✅ Error handling with Either type
- ✅ Reusable UI components
- ✅ Dark/Light theme support
- ✅ Localization ready
- ✅ **Environment configuration** (dev, staging, prod)
- ✅ **Logger service** with debug, info, warning, error levels
- ✅ **Real connectivity monitoring** with connectivity_plus
- ✅ **Async state management** with pattern matching
- ✅ **Dialog & Snackbar utilities**
- ✅ **Date/time utilities**
- ✅ **Design system** (spacing, radius, shadows)
- ✅ **Cached network images** with placeholder/error states
- ✅ **Pagination support** for list APIs

## Architecture

```
lib/
├── main.dart                       # Development entry point
├── main_staging.dart               # Staging entry point
├── main_prod.dart                  # Production entry point
├── app.dart                        # App widget with MaterialApp
├── bootstrap.dart                  # App initialization & error handling
├── core/                           # Core utilities and configurations
│   ├── config/                    # Environment configuration
│   ├── constants/                  # App constants, API endpoints, strings, dimensions
│   ├── di/                        # Dependency injection (GetIt)
│   ├── errors/                    # Failures & Exceptions
│   ├── network/                   # Network client (Dio), API response wrapper
│   ├── router/                    # GoRouter configuration
│   ├── state/                     # Async state classes
│   ├── theme/                     # App themes
│   ├── usecase/                   # Base use case interfaces
│   └── utils/                     # Extensions, validators, logger, dialog, date utils
├── features/                      # Feature modules
│   └── auth/                      # Authentication feature
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Remote & local data sources
│       │   ├── models/            # JSON serializable models
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Domain layer
│       │   ├── entities/          # Business entities
│       │   ├── repositories/      # Repository interfaces
│       │   └── usecases/          # Use cases
│       └── presentation/          # Presentation layer
│           ├── pages/             # Screens
│           ├── providers/         # Riverpod providers
│           └── widgets/           # Feature widgets
└── shared/                        # Shared components
    └── widgets/                   # Reusable widgets
```

## Packages Used

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `riverpod_annotation` | Riverpod code generation annotations |
| `dio` | HTTP client for API calls |
| `go_router` | Declarative routing with auth guards |
| `get_it` | Dependency injection |
| `dartz` | Functional programming (Either type) |
| `hive` & `hive_flutter` | Local storage |
| `json_annotation` | JSON serialization annotations |
| `shimmer` | Loading skeleton animations |
| `flutter_localizations` | App localization |
| `connectivity_plus` | Network connectivity monitoring |
| `cached_network_image` | Image caching |
| `intl` | Date/time formatting |

## Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure Environment

Update `lib/core/config/env_config.dart`:

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

## Creating a New Feature

### 1. Create the folder structure:

```
lib/features/<feature_name>/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

### 2. Create files in order:

1. **Domain Layer** (start here)
   - `entities/` - Business entities (pure Dart classes)
   - `repositories/` - Abstract repository interfaces
   - `usecases/` - Single-responsibility use cases

2. **Data Layer**
   - `models/` - Data models with `@JsonSerializable()`
   - `datasources/` - Remote (API) and local (Hive) data sources
   - `repositories/` - Repository implementations

3. **Presentation Layer**
   - `providers/` - Riverpod providers (StateNotifier recommended)
   - `widgets/` - Feature-specific widgets
   - `pages/` - Screen widgets

### 3. Register in DI

Add to `core/di/injection_container.dart`:

```dart
Future<void> _initYourFeature() async {
  // Data Sources
  sl.registerLazySingleton<YourRemoteDataSource>(
    () => YourRemoteDataSourceImpl(networkClient: sl()),
  );
  
  // Repository
  sl.registerLazySingleton<YourRepository>(
    () => YourRepositoryImpl(remoteDataSource: sl()),
  );
  
  // Use Cases
  sl.registerLazySingleton(() => YourUseCase(sl()));
}
```

### 4. Add Routes

Update `core/router/app_router.dart`:

```dart
GoRoute(
  path: '/your-route',
  name: 'your-route',
  builder: (context, state) => const YourPage(),
),
```

## Code Generation

After creating/modifying models with `@JsonSerializable()`:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. **Domain layer is independent** - No Flutter/external package imports
2. **Use Either for error handling** - `Either<Failure, Success>` pattern
3. **Single responsibility** - One use case = one action
4. **StateNotifier for state** - Immutable state with copyWith
5. **Dependency inversion** - Depend on abstractions, not implementations
6. **Keep providers simple** - Business logic in use cases, not providers

## Utility Usage Examples

### Logger

```dart
AppLogger.d('Debug message');
AppLogger.i('Info message', tag: 'AUTH');
AppLogger.w('Warning message');
AppLogger.e('Error message', error: exception, stackTrace: stack);
AppLogger.network('GET', '/api/users', statusCode: 200);
```

### Dialogs & Snackbars

```dart
// Show confirmation dialog
final confirmed = await AppDialogs.showConfirmation(
  context,
  title: 'Delete?',
  message: 'Are you sure?',
  isDanger: true,
);

// Show snackbars
AppSnackbars.showSuccess(context, 'Saved successfully');
AppSnackbars.showError(context, 'Something went wrong');
```

### Async State Pattern

```dart
// In provider
state.when(
  initial: () => Container(),
  loading: () => LoadingWidget(),
  success: (data) => DataWidget(data),
  error: (failure) => ErrorWidget(message: failure.message),
);
```

### Date Utils

```dart
DateTimeUtils.formatDate(DateTime.now());        // "15/01/2024"
DateTimeUtils.getRelativeTime(someDate);         // "2 hours ago"
DateTimeUtils.isToday(DateTime.now());           // true
```

## Error Handling

The app uses a unified error handling approach:

- `Exceptions` - Thrown in data layer (network, cache errors)
- `Failures` - Returned in domain layer (converted from exceptions)
- UI displays appropriate error messages based on failure type

## License

MIT License
