import 'package:intl/intl.dart';

String transformDateFormat(String originalDate) {
  DateTime parsedDate = DateTime.parse(originalDate);
  String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
  return formattedDate;
}
