import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Feature {
  darkModeToggle,
  biometricAuth,
  pushNotifications,
  analytics,
  crashReporting,
  inAppPurchases,
  socialLogin,
  offlineMode,
  abTesting,
  newOnboarding,
  betaFeatures,
}

class FeatureFlags {
  FeatureFlags._();

  static final Map<Feature, bool> _flags = {
    Feature.darkModeToggle: true,
    Feature.biometricAuth: false,
    Feature.pushNotifications: true,
    Feature.analytics: true,
    Feature.crashReporting: true,
    Feature.inAppPurchases: false,
    Feature.socialLogin: false,
    Feature.offlineMode: true,
    Feature.abTesting: false,
    Feature.newOnboarding: false,
    Feature.betaFeatures: false,
  };

  static bool isEnabled(Feature feature) {
    return _flags[feature] ?? false;
  }

  static void enable(Feature feature) {
    _flags[feature] = true;
  }

  static void disable(Feature feature) {
    _flags[feature] = false;
  }

  static void toggle(Feature feature) {
    _flags[feature] = !(_flags[feature] ?? false);
  }

  static void setFromRemoteConfig(Map<String, bool> remoteFlags) {
    for (final entry in remoteFlags.entries) {
      try {
        final feature = Feature.values.firstWhere((f) => f.name == entry.key);
        _flags[feature] = entry.value;
      } catch (_) {}
    }
  }

  static List<Feature> get enabledFeatures {
    return _flags.entries.where((e) => e.value).map((e) => e.key).toList();
  }

  static List<Feature> get disabledFeatures {
    return _flags.entries.where((e) => !e.value).map((e) => e.key).toList();
  }
}

final featureFlagsProvider = Provider<FeatureFlagsNotifier>((ref) {
  return FeatureFlagsNotifier();
});

class FeatureFlagsNotifier {
  bool isEnabled(Feature feature) => FeatureFlags.isEnabled(feature);

  void enable(Feature feature) => FeatureFlags.enable(feature);

  void disable(Feature feature) => FeatureFlags.disable(feature);

  void toggle(Feature feature) => FeatureFlags.toggle(feature);
}

extension FeatureExtension on Feature {
  bool get isEnabled => FeatureFlags.isEnabled(this);
}
