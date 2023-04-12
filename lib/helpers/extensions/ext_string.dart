import 'package:intl/intl.dart';
import 'package:santriku/helpers/extensions/ext_int.dart';
import 'package:santriku/helpers/formatters/FormatterRupiah.dart';
import 'package:santriku/helpers/formatters/FormatterTanggal.dart';

extension intParsing on int? {
  String toRupiah() {
    return FormatterRupiah.format(this);
  }

  String toRibuan() {
    return NumberFormat.currency(locale: 'id', name: "", decimalDigits: 0)
        .format(this ?? 0);
  }
}

extension doubleParsing on double {
  String toKM() {
    // double angka=10.57564212432323;
    double angka = this / 1000;
    print("origin angka:$angka");
    final angkaKomaSatu = double.parse(angka.toStringAsFixed(1));
    print("rounded:$angkaKomaSatu");
    final angkaKoma = angkaKomaSatu - angkaKomaSatu.truncate();
    print("fraction:$angkaKoma");
    String result =
        angkaKoma > 0 ? angka.toStringAsFixed(1) : angka.toStringAsFixed(0);
    print("result:$result");

    return result + " Km";
  }
}

extension intNoNullParsing on int {
  String toTanggal(String formatTujuan) {
    final theDate = DateTime.fromMillisecondsSinceEpoch(this);
    final outputFormat = DateFormat(formatTujuan, "id");
    final outputDate = outputFormat.format(theDate);
    return outputDate;
  }

  String get topupStatus {
    if (this == 1) {
      return "Menunggu Transfer";
    }
    if (this == 2) {
      return "Diterima";
    }
    return "";
  }
}

extension tanggalStr on DateTime {
  String toTanggal(String formatTujuan) {
    final outputFormat = DateFormat(formatTujuan, "id");
    final outputDate = outputFormat.format(this);
    return outputDate;
  }
}

extension tglParsing on String {
  String konvertTanggal(String formatFrom, String formatTo) {
    return FormatterTanggal.konvert(
      formatFrom,
      formatTo,
      this,
    );
  }

  String get getPhoneNumber {
    final theAngka = this.getAngka.toString();
    String phoneNumber = "";
    if (theAngka.startsWith("62")) {
      return theAngka;
    }
    if (theAngka.startsWith("0")) {
      phoneNumber = "62" + theAngka.substring(1);
      return phoneNumber;
    }

    return "62" + theAngka;
  }
}
