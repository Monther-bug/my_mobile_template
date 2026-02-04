import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/env_config.dart';

/// Staging entry point
/// Run with: flutter run -t lib/main_staging.dart
void main() {
  bootstrap(() => const App(), environment: EnvConfig.staging);
}
