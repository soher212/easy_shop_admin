import 'package:intl/intl.dart';

String formatPrice(double value) {
  return value == value.truncateToDouble()
      ? value.toStringAsFixed(0)
      : value.toStringAsFixed(2);
}

String formatDateTime(DateTime date, {String locale = 'en'}) {
  return DateFormat.yMMMd(locale).add_jm().format(date);
}

String formatDate(DateTime date, {String locale = 'en'}) {
  return DateFormat.yMMMd(locale).format(date);
}
