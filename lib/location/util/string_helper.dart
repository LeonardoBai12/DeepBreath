import 'package:intl/intl.dart';

String transformDateFormat(String originalDate) {
  try {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(originalDate));
  } catch (_) {
    return originalDate.isEmpty ? 'N/A' : originalDate;
  }
}
