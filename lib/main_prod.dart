import 'app/app.dart';
import 'app/bootstrap.dart';
import 'core/config/env_config.dart';

void main() {
  bootstrap(() => const App(), environment: EnvConfig.prod);
}
