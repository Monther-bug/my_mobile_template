import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});

final globalLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final isOnlineProvider = StateProvider<bool>((ref) {
  return true;
});

final appLifecycleProvider = StateProvider<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
});
