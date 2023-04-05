import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart'; 

class InputDateFormatter extends TextInputFormatter {
  final String suffixText;
  InputDateFormatter(this.suffixText);
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    const mask = "##/##/####";
    const separator = "/";
    String newIsian = "";

    String newNumbers = newValue.text;
    // if (!newNumbers.endsWith(separator)) {
    //   newNumbers = newNumbers + separator;
    // }
    newNumbers = newNumbers.replaceAll(separator, "");

    final splitted = newNumbers.split("");
    debugPrint("jumlah splitted " + splitted.length.toString());

    splitted.asMap().forEach((key, value) {
      newIsian = newIsian + value;
      if (key == 1 || key == 3) {
        newIsian = newIsian + separator;
      }
    });

    // splitted.forEach((element) {
    //   final hasilProses = processField(element, 0, 2);
    //   newIsian = newIsian + hasilProses;
    //   if (newNumbers.length > newIsian.length) {
    //     newIsian = newIsian + "a";
    //   }
    // });

    // if (splitted.length > 0) {
    //   final hasilProses = processField(splitted[0], 0, 2);
    //   newIsian = newIsian + hasilProses;
    //   if (hasilProses.length < splitted[0].length) {
    //     newIsian = newIsian + separator;
    //     splitted.add(splitted[0].substring(2));
    //   }
    // }
    // if (splitted.length > 1) {
    //   final hasilProses = processField(splitted[1], 0, 2);
    //   newIsian = newIsian + hasilProses;
    //   if (hasilProses.length < splitted[1].length) {
    //     newIsian = newIsian + separator;
    //     splitted.add(splitted[1].substring(2));
    //   }
    // }
    // if (splitted.length > 2) {
    //   newIsian = newIsian + processField(splitted[2], 0, 2);
    // }
    // newIsian = processField(newNumbers, 0, 2) +
    //     processField(newNumbers, 3, 2) +
    //     processField(newNumbers, 6, 4, separator: "");
    if (newIsian.endsWith(separator)) {
      newIsian = newIsian.substring(0, newIsian.length - 1);
    }

    return newValue.copyWith(
      text: newIsian,
      selection: TextSelection.collapsed(offset: newIsian.length),
    );
  }

  String processField(String theText, int rangeFirst, int rangeLength,
      {separator = "/"}) {
    String theResult = "";

    if (rangeFirst < theText.length) {
      final int rangeLong = rangeFirst + rangeLength;
      final maxLoop = rangeLong <= theText.length ? rangeLong : theText.length;
      for (var i = rangeFirst; i < maxLoop; i++) {
        theResult += theText[i];
      }

      if (theResult.length == rangeLength) {
        theResult = theResult += separator;
      }
      theResult = theResult.replaceAll(separator + separator, "");
    }

    return theResult;
  }
}
