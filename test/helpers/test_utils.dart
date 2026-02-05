import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

/// Base test utilities for widget and integration testing

/// Wraps a widget with necessary providers for testing
Widget testableWidget({
  required Widget child,
  List<Override>? overrides,
  NavigatorObserver? navigatorObserver,
  ThemeData? theme,
  Locale? locale,
}) {
  return ProviderScope(
    overrides: overrides ?? [],
    child: MaterialApp(
      home: child,
      theme: theme ?? ThemeData.light(),
      locale: locale,
      navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
    ),
  );
}

/// Wraps a widget with MaterialApp for basic testing
Widget materialTestWidget({required Widget child, ThemeData? theme}) {
  return MaterialApp(
    home: Scaffold(body: child),
    theme: theme ?? ThemeData.light(),
  );
}

/// Creates a mock callback that tracks calls
class MockCallback extends Mock {
  void call();
}

/// Creates a mock async callback
class MockAsyncCallback extends Mock {
  Future<void> call();
}

/// Creates a mock callback with a single parameter
class MockCallbackWithParam<T> extends Mock {
  void call(T param);
}

/// Extension methods for WidgetTester
extension WidgetTesterX on WidgetTester {
  /// Pumps and settles with a timeout
  Future<void> pumpAndSettleWithTimeout({
    Duration timeout = const Duration(seconds: 10),
  }) async {
    await pumpAndSettle(
      const Duration(milliseconds: 100),
      EnginePhase.sendSemanticsUpdate,
      timeout,
    );
  }

  /// Taps a widget by key and pumps
  Future<void> tapByKey(Key key) async {
    await tap(find.byKey(key));
    await pump();
  }

  /// Taps a widget by text and pumps
  Future<void> tapByText(String text) async {
    await tap(find.text(text));
    await pump();
  }

  /// Enters text in a field by key
  Future<void> enterTextByKey(Key key, String text) async {
    await enterText(find.byKey(key), text);
    await pump();
  }

  /// Scrolls until a widget is visible
  Future<void> scrollUntilVisible(
    Finder finder, {
    double delta = 100,
    int maxScrolls = 50,
    Duration duration = const Duration(milliseconds: 100),
  }) async {
    for (int i = 0; i < maxScrolls; i++) {
      if (finder.evaluate().isNotEmpty) {
        return;
      }
      await drag(find.byType(Scrollable).first, Offset(0, -delta));
      await pump(duration);
    }
  }

  /// Waits for a finder to find a widget
  Future<void> waitFor(
    Finder finder, {
    Duration timeout = const Duration(seconds: 10),
    Duration interval = const Duration(milliseconds: 100),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await pump(interval);
      if (finder.evaluate().isNotEmpty) {
        return;
      }
    }
    throw TimeoutException('Widget not found: $finder');
  }
}

/// Custom timeout exception for tests
class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);

  @override
  String toString() => 'TimeoutException: $message';
}

/// Test data builders for common entities
class TestDataBuilder {
  /// Creates a mock DateTime
  static DateTime mockDateTime({
    int year = 2024,
    int month = 1,
    int day = 1,
    int hour = 12,
    int minute = 0,
  }) {
    return DateTime(year, month, day, hour, minute);
  }

  /// Creates a unique ID
  static String uniqueId([String prefix = 'test']) {
    return '${prefix}_${DateTime.now().millisecondsSinceEpoch}';
  }
}

/// Matcher for widget with specific key
Matcher hasKey(Key key) =>
    predicate<Widget>((widget) => widget.key == key, 'has key $key');

/// Matcher for widget containing specific text
Matcher containsText(String text) =>
    predicate<Text>((widget) => widget.data?.contains(text) ?? false);

/// Runs a test with timeout
Future<void> runWithTimeout(
  Future<void> Function() test, {
  Duration timeout = const Duration(seconds: 30),
}) async {
  await Future.any([
    test(),
    Future.delayed(timeout).then((_) {
      throw TimeoutException('Test timed out after ${timeout.inSeconds}s');
    }),
  ]);
}

/// Golden test helper
Future<void> expectGolden(
  WidgetTester tester,
  Widget widget,
  String goldenName,
) async {
  await tester.pumpWidget(materialTestWidget(child: widget));
  await expectLater(
    find.byType(widget.runtimeType),
    matchesGoldenFile('goldens/$goldenName.png'),
  );
}

/// Provider test helper
void verifyProviderState<T>(
  ProviderContainer container,
  ProviderListenable<T> provider,
  T expectedState,
) {
  expect(container.read(provider), expectedState);
}

/// Async provider test helper
Future<void> verifyAsyncProviderState<T>(
  ProviderContainer container,
  ProviderListenable<AsyncValue<T>> provider,
  T expectedData,
) async {
  final state = container.read(provider);
  expect(state, isA<AsyncData<T>>());
  expect((state as AsyncData<T>).value, expectedData);
}
