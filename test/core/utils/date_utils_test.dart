import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_template/core/utils/date_utils.dart';

void main() {
  group('DateTimeUtils', () {
    group('formatDate', () {
      test('should format date correctly', () {
        final date = DateTime(2024, 1, 15);
        expect(DateTimeUtils.formatDate(date), '15/01/2024');
      });

      test('should return empty string for null date', () {
        expect(DateTimeUtils.formatDate(null), '');
      });
    });

    group('formatTime', () {
      test('should format time correctly', () {
        final date = DateTime(2024, 1, 15, 14, 30);
        expect(DateTimeUtils.formatTime(date), '14:30');
      });

      test('should return empty string for null date', () {
        expect(DateTimeUtils.formatTime(null), '');
      });
    });

    group('formatDateTime', () {
      test('should format date and time correctly', () {
        final date = DateTime(2024, 1, 15, 14, 30);
        expect(DateTimeUtils.formatDateTime(date), '15/01/2024 14:30');
      });
    });

    group('getRelativeTime', () {
      test('should return "Just now" for very recent time', () {
        final now = DateTime.now();
        expect(DateTimeUtils.getRelativeTime(now), 'Just now');
      });

      test('should return minutes ago for recent time', () {
        final date = DateTime.now().subtract(const Duration(minutes: 5));
        expect(DateTimeUtils.getRelativeTime(date), '5 minutes ago');
      });

      test('should return hours ago', () {
        final date = DateTime.now().subtract(const Duration(hours: 3));
        expect(DateTimeUtils.getRelativeTime(date), '3 hours ago');
      });

      test('should return "Yesterday" for yesterday', () {
        final date = DateTime.now().subtract(const Duration(days: 1));
        expect(DateTimeUtils.getRelativeTime(date), 'Yesterday');
      });

      test('should return days ago', () {
        final date = DateTime.now().subtract(const Duration(days: 5));
        expect(DateTimeUtils.getRelativeTime(date), '5 days ago');
      });
    });

    group('isToday', () {
      test('should return true for today', () {
        expect(DateTimeUtils.isToday(DateTime.now()), true);
      });

      test('should return false for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(DateTimeUtils.isToday(yesterday), false);
      });

      test('should return false for null', () {
        expect(DateTimeUtils.isToday(null), false);
      });
    });

    group('isYesterday', () {
      test('should return true for yesterday', () {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        expect(DateTimeUtils.isYesterday(yesterday), true);
      });

      test('should return false for today', () {
        expect(DateTimeUtils.isYesterday(DateTime.now()), false);
      });
    });

    group('startOfDay', () {
      test('should return start of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final start = DateTimeUtils.startOfDay(date);
        expect(start, DateTime(2024, 1, 15, 0, 0, 0));
      });
    });

    group('endOfDay', () {
      test('should return end of day', () {
        final date = DateTime(2024, 1, 15, 14, 30, 45);
        final end = DateTimeUtils.endOfDay(date);
        expect(end, DateTime(2024, 1, 15, 23, 59, 59, 999));
      });
    });

    group('tryParse', () {
      test('should parse ISO format', () {
        final result = DateTimeUtils.tryParse('2024-01-15T14:30:00');
        expect(result, isNotNull);
        expect(result?.year, 2024);
        expect(result?.month, 1);
        expect(result?.day, 15);
      });

      test('should return null for invalid format', () {
        expect(DateTimeUtils.tryParse('invalid'), isNull);
        expect(DateTimeUtils.tryParse(''), isNull);
        expect(DateTimeUtils.tryParse(null), isNull);
      });
    });
  });
}
