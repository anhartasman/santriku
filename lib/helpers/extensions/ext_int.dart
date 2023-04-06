import 'package:intl/intl.dart';

extension strParsing on String {
  int get getAngka {
    try {
      return int.parse((this).replaceAll(new RegExp(r'[^0-9]'), ''));
    } catch (e) {
      return 0;
    }
  }

  int getAngkaTanggal(String formatAwal) {
    final f = new DateFormat(formatAwal);
    final theDate = f.parse(this);

    return theDate.millisecondsSinceEpoch;
  }
}
