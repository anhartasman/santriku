import 'package:intl/intl.dart';

class FormatterRupiah {
  static String format(int? theAngka) {
    return NumberFormat.currency(locale: 'id', name: "Rp ", decimalDigits: 0)
        .format(theAngka ?? 0);
  }
}
