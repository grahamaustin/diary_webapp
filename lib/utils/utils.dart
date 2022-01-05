import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('EE, d MMMM y – ').format(date);
}

String formatTime(DateTime time) {
  return DateFormat.jm().format(time);
}
