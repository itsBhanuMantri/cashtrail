import 'package:intl/intl.dart';

String formatInr(num amount) {
  final formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
    customPattern: '¤#,##,##0',
  );
  return formatter.format(amount);
}