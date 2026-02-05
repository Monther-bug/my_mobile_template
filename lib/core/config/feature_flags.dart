import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Feature flag definitions
enum Feature {
  /// Enable dark mode toggle
  darkModeToggle,

  /// Enable biometric authentication
  biometricAuth,

  /// Enable push notifications
  pushNotifications,

  /// Enable analytics tracking
  analytics,

  /// Enable crash reporting
  crashReporting,

  /// Enable in-app purchases
  inAppPurchases,

  /// Enable social login (Google, Apple, etc.)
  socialLogin,

  /// Enable offline mode
  offlineMode,

  /// Enable A/B testing
  abTesting,

  /// New onboarding flow
  newOnboarding,

  /// Beta features
  betaFeatures,
}

/// Feature flags service for controlling feature visibility
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

  /// Check if a feature is enabled
  static bool isEnabled(Feature feature) {
    return _flags[feature] ?? false;
  }

  /// Enable a feature
  static void enable(Feature feature) {
    _flags[feature] = true;
  }

  /// Disable a feature
  static void disable(Feature feature) {
    _flags[feature] = false;
  }

  /// Toggle a feature
  static void toggle(Feature feature) {
    _flags[feature] = !(_flags[feature] ?? false);
  }

  /// Set all flags from remote config
  static void setFromRemoteConfig(Map<String, bool> remoteFlags) {
    for (final entry in remoteFlags.entries) {
      try {
        final feature = Feature.values.firstWhere(
          (f) => f.name == entry.key,
        );
        _flags[feature] = entry.value;
      } catch (_) {
        // Feature not found, ignore
      }
    }
  }

  /// Get all enabled features
  static List<Feature> get enabledFeatures {
    return _flags.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();
  }

  /// Get all disabled features
  static List<Feature> get disabledFeatures {
    return _flags.entries
        .where((e) => !e.value)
        .map((e) => e.key)
        .toList();
  }
}

/// Riverpod provider for feature flags
final featureFlagsProvider = Provider<FeatureFlagsNotifier>((ref) {
  return FeatureFlagsNotifier();
});

/// Feature flags notifier for reactive updates
class FeatureFlagsNotifier {
  bool isEnabled(Feature feature) => FeatureFlags.isEnabled(feature);

  void enable(Feature feature) => FeatureFlags.enable(feature);

  void disable(Feature feature) => FeatureFlags.disable(feature);

  void toggle(Feature feature) => FeatureFlags.toggle(feature);
}

/// Extension for easy feature checking
extension FeatureExtension on Feature {
  bool get isEnabled => FeatureFlags.isEnabled(this);
}
