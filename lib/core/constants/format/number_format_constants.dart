part of 'format_constants.dart';

class NumberFormatConstants {
  NumberFormatConstants._();

  static const String defaultFormat = '#,###';

  static String formatNumber(int number) {
    if (number >= 1000000) {
      double result = number / 1000000.0;

      return '${result.toStringAsFixed(0)}M';
    } else if (number >= 1000) {
      double result = number / 1000.0;

      return '${result.toStringAsFixed(0)}k';
    } else {
      return '$number';
    }
  }
}
