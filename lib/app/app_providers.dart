import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App-level providers for global state

/// Theme mode provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

/// Locale provider for app language
final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});

/// Global loading overlay provider
final globalLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

/// Network connectivity provider
final isOnlineProvider = StateProvider<bool>((ref) {
  return true;
});

/// App lifecycle state provider
final appLifecycleProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
