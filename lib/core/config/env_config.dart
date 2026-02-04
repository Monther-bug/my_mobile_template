/// App environment configuration
enum Environment { dev, staging, prod }

/// Environment configuration for different build flavors
class EnvConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableCrashReporting;

  const EnvConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableCrashReporting,
  });

  /// Development environment
  static const EnvConfig dev = EnvConfig._(
    environment: Environment.dev,
    apiBaseUrl: 'https://dev-api.example.com',
    enableLogging: true,
    enableCrashReporting: false,
  );

  /// Staging environment
  static const EnvConfig staging = EnvConfig._(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging-api.example.com',
    enableLogging: true,
    enableCrashReporting: true,
  );

  /// Production environment
  static const EnvConfig prod = EnvConfig._(
    environment: Environment.prod,
    apiBaseUrl: 'https://api.example.com',
    enableLogging: false,
    enableCrashReporting: true,
  );

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}

/// Global app configuration - set this in main.dart
class AppConfig {
  static late EnvConfig _config;

  static void init(EnvConfig config) {
    _config = config;
  }

  static EnvConfig get current => _config;
  static String get apiBaseUrl => _config.apiBaseUrl;
  static bool get enableLogging => _config.enableLogging;
  static Environment get environment => _config.environment;
}
