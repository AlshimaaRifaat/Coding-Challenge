import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats the time in HH:mm format
  static String formatTime(DateTime dateTime) {
    return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  /// Formats the date in 'E. d. MMM' format, e.g., "So. 2. Feb"
  static String formatDate(DateTime dateTime) {
    return DateFormat('E. d. MMM').format(dateTime);
  }

  /// Calculates the approximate week number in the month
  static String formatWeekNumber(DateTime dateTime) {
    return "KW ${((dateTime.day - 1) ~/ 7) + 1}";
  }
}
