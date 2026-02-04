import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/env_config.dart';

/// Production entry point
/// Run with: flutter run -t lib/main_prod.dart
void main() {
  bootstrap(() => const App(), environment: EnvConfig.prod);
}
