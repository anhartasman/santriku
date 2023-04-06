import 'package:intl/intl.dart';

class FormatterTanggal {
  static String konvert(
      String formatAwal, String formatTujuan, String theTanggal) {
    final f = new DateFormat(formatAwal);
    final theDate = f.parse(theTanggal);
    final outputFormat = DateFormat(formatTujuan, "id");
    final outputDate = outputFormat.format(theDate);
    return outputDate;
  }
}
