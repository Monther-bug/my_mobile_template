import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/env_config.dart';

/// Development entry point
void main() {
  bootstrap(() => const App(), environment: EnvConfig.dev);
}
