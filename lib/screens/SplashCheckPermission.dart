import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saibupi/screens/models/IzinAplikasi.dart';
import 'package:saibupi/widgets/ButtonMain.dart';
import 'package:saibupi/widgets/ButtonPutih.dart';
import 'package:saibupi/widgets/SplashContent.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';

class SplashCheckPermission extends StatefulWidget {
  final Function onSuccess;
  const SplashCheckPermission({
    Key? key,
    required this.onSuccess,
  }) : super(key: key);
  @override
  _SplashCheckPermissionState createState() => _SplashCheckPermissionState();
}

class _SplashCheckPermissionState extends State<SplashCheckPermission> {
  bool gagalPermission = false;
  int permissionIdx = -1;
  String progressErrorMessage = "";
  List<IzinAplikasi> permission_list = [
    IzinAplikasi(
      permission: Permission.storage,
      nama: "Mengakses penyimpanan",
    ),
    IzinAplikasi(
      permission: Permission.camera,
      nama: "Mengakses kamera",
    ),
  ];

  @override
  void initState() {
    // set status bar color to transparent and navigation bottom color to black21
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    checkUserPermission();
    super.initState();
  }

  @override
  void dispose() {
    controllerProgress.close();

    super.dispose();
  }

  void tampilanError(String pesan) async {
    await TampilanDialog.showDialogAlert(pesan);
    quitApp();
  }

  void quitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }

  StreamController<String> controllerProgress = StreamController<String>();

  void checkUserPermission() async {
    permissionIdx = 0;
    try {
      while (true) {
        final permissionName = permission_list[permissionIdx].nama;
        print("Checking permission " + permissionName);
        final permissionStatus =
            await permission_list[permissionIdx].permission.request();
        if (permissionStatus.isGranted) {
          setState(() {
            permissionIdx += 1;
          });
          ;
          if (permissionIdx >= permission_list.length) {
            break;
          }
        } else {
          throw ("izin_exception." + permissionName);
        }
        await Future.delayed(Duration(milliseconds: 100), () {});
      }

      Future.delayed(Duration(milliseconds: 500))
          .then((value) => widget.onSuccess());
    } catch (error) {
      final errorMsg = error.toString();
      final permissionName =
          errorMsg.contains("izin_exception") ? errorMsg.split(".")[1] : "";
      progressErrorMessage =
          "Aplikasi butuh izin $permissionName, buka pengaturan";
      setState(() {
        gagalPermission = true;
      });
      //_logger.warning(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SplashContent(),
              ),
              SizedBox(height: 16),
              if (gagalPermission)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Izin Aplikasi",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Beberapa fitur membutuhkan izin penggunaan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: checkUserPermission,
                                child: ButtonPutih("Ulangi"))),
                        SizedBox(width: 20),
                        Expanded(
                          child: InkWell(
                              onTap: () => openAppSettings(),
                              child: ButtonMain("Pengaturan")),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
