import 'package:intl/intl.dart';

/// Date and time utilities
class DateTimeUtils {
  DateTimeUtils._();

  // Common date formats
  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy');
  static final DateFormat _dayMonthFormat = DateFormat('dd MMM');
  static final DateFormat _fullFormat = DateFormat('EEEE, dd MMMM yyyy');
  static final DateFormat _isoFormat = DateFormat('yyyy-MM-dd');

  /// Format date as dd/MM/yyyy
  static String formatDate(DateTime? date) {
    if (date == null) return '';
    return _dateFormat.format(date);
  }

  /// Format time as HH:mm
  static String formatTime(DateTime? date) {
    if (date == null) return '';
    return _timeFormat.format(date);
  }

  /// Format date and time as dd/MM/yyyy HH:mm
  static String formatDateTime(DateTime? date) {
    if (date == null) return '';
    return _dateTimeFormat.format(date);
  }

  /// Format as MMMM yyyy (e.g., January 2024)
  static String formatMonthYear(DateTime? date) {
    if (date == null) return '';
    return _monthYearFormat.format(date);
  }

  /// Format as dd MMM (e.g., 15 Jan)
  static String formatDayMonth(DateTime? date) {
    if (date == null) return '';
    return _dayMonthFormat.format(date);
  }

  /// Format as full date (e.g., Monday, 15 January 2024)
  static String formatFull(DateTime? date) {
    if (date == null) return '';
    return _fullFormat.format(date);
  }

  /// Format as ISO date (yyyy-MM-dd) for API
  static String formatIso(DateTime? date) {
    if (date == null) return '';
    return _isoFormat.format(date);
  }

  /// Get relative time string (e.g., "2 hours ago", "Yesterday")
  static String getRelativeTime(DateTime? date) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime? date) {
    if (date == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Parse date from various string formats
  static DateTime? tryParse(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    // Try ISO format first
    final isoDate = DateTime.tryParse(dateString);
    if (isoDate != null) return isoDate;

    // Try common formats
    final formats = [
      'dd/MM/yyyy',
      'dd-MM-yyyy',
      'MM/dd/yyyy',
      'yyyy/MM/dd',
      'dd/MM/yyyy HH:mm',
      'dd/MM/yyyy HH:mm:ss',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (_) {
        continue;
      }
    }

    return null;
  }
}
