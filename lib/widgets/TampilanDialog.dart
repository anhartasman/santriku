import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:santriku/theme/colors/Warna.dart';
import 'package:santriku/widgets/ButtonMain.dart';
import 'package:santriku/widgets/ButtonPutih.dart';

class TampilanDialog {
  static Future<File?> DialogFilePicker() async {
    late File selectedImage;

    final picker = ImagePicker();

    var pilihanBrowser = await Get.dialog(AlertDialog(
      title: Text("Mengambil Foto"),
      content: Text("Pilih Sumber"),
      actions: <Widget>[
        TextButton(
          child: Text("Kamera"),
          onPressed: () {
            Get.back(result: "kamera");
          },
        ),
        TextButton(
          child: Text("File"),
          onPressed: () {
            Get.back(result: "file");
          },
        )
      ],
    ));

    if (pilihanBrowser != null) {
      print("pilihanBrowser : ${pilihanBrowser}");

      if (pilihanBrowser == "kamera") {
        final pickedFile = await picker.pickImage(source: ImageSource.camera);
        File _image = File(pickedFile!.path);
        selectedImage = _image;

        if (selectedImage != null) {
          return (selectedImage);
        }
      }
      if (pilihanBrowser == "file") {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
        File _image = File(pickedFile!.path);
        selectedImage = _image;

        if (selectedImage != null) {
          return (selectedImage);
        }
      }
    }
    return null;
    // final pickedFile = await picker.getImage(source: ImageSource.camera);

    // setState(() {
    //   _image = File(pickedFile.path);
    // });
  }

  static Future<void> showDialogAlert(
    String message, {
    String? title,
    bool withDelay = false,
    int delaySeconds: 1,
  }) {
    return showDialogPesan(
      message,
      title: title,
      ikonPesan: IkonDialogPesan.alert,
      withDelay: withDelay,
      delaySeconds: delaySeconds,
      textColor: Colors.red,
    );
  }

  static Future<void> showDialogSuccess(
    String message, {
    String title: "Berhasil",
    bool withDelay = false,
    int delaySeconds: 1,
  }) {
    return showDialogPesan(
      message,
      title: title,
      ikonPesan: IkonDialogPesan.success,
      withDelay: withDelay,
      delaySeconds: delaySeconds,
      textColor: Warna.WARNA_BIRU,
    );
  }

  static Future<void> showDialogPesan(
    String message, {
    String? title,
    FaIcon ikonPesan: IkonDialogPesan.success,
    bool withDelay = false,
    int delaySeconds: 1,
    Color textColor: Warna.BLACK21,
  }) async {
    if (withDelay) {
      await Future.delayed(Duration(seconds: delaySeconds));
    }
    await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ikonPesan,
            title != null
                ? Column(children: [
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ])
                : SizedBox(
                    height: 20,
                  ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) => Color(0xFF0CA7FB),
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    )),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  static Future<bool> showDialogKonfirm(
    String tulisan, {
    BuildContext? context,
    GlobalKey? key,
    String txtNo = "Tidak",
    String txtYes = "Ya",
    String title = "Konfirmasi",
  }) async {
    bool isiKonfirm = false;
    await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/icon/warning.png',
              width: 50,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Warna.BLACK21,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              tulisan,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Warna.BLACK21),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {
                        isiKonfirm = true;
                        Get.back();
                      },
                      child: ButtonMain(txtYes)),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: ButtonPutih(txtNo))),
              ],
            )
          ],
        ),
      ),
    ));
    return isiKonfirm;
  }

  static Future<DateTime?> DatePicker({
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool yearFirst: false,
  }) {
    return showRoundedDatePicker(
      context: Get.context!,
      locale: Locale("id", "ID"),
      initialDatePickerMode:
          yearFirst ? DatePickerMode.year : DatePickerMode.day,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime.now().subtract(Duration(days: 1)),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 2),
      borderRadius: 16,
    ).then((newDateTime) {
      return newDateTime;
      // if (newDateTime != null) {
      //   return newDateTime;
      // }

      // return initialDate ?? DateTime.now();
    });
  }
}

class IkonDialogPesan {
  static const FaIcon alert = FaIcon(
    FontAwesomeIcons.exclamationCircle,
    size: 70,
    color: Colors.red,
  );
  static const FaIcon success = FaIcon(
    FontAwesomeIcons.solidCheckCircle,
    size: 70,
    color: Warna.WARNA_BIRU,
  );
}
