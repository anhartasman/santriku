import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:santriku/theme/colors/Warna.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/TampilanDialog.dart';

class PhotoChild extends StatefulWidget {
  final File? initialFile;
  final Function(File) onChanged;
  const PhotoChild({
    Key? key,
    required this.initialFile,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PhotoChild> createState() => PhotoChildState();
}

class PhotoChildState extends State<PhotoChild> {
  File? theFile;
  bool cariUkuran = true;
  var widgetKey = GlobalKey();
  late final imageWidth;
  late final imageHeight;
  @override
  void initState() {
    theFile = widget.initialFile;
    super.initState();
  }

  void postFrameCallback(_) {
    if (cariUkuran) {
      cariUkuran = false;
      var context = widgetKey.currentContext;
      if (context == null) return;
      if (context.size == null) return;
      imageWidth = context.size!.width;
      imageHeight = context.size!.height;
      setState(() {
        theFile = widget.initialFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => TampilanDialog.DialogFilePicker().then((value) {
              if (value != null) {
                setState(() {
                  theFile = value;
                });
                widget.onChanged(theFile!);
              }
            }),
            child: theBox(),
          ),
        ],
      ),
    );
  }

  Widget theBox() {
    final double appWidth = MediaQuery.of(context).size.width;
    final boxWidth = appWidth * 0.5;
    final boxHeight = boxWidth * 0.5;
    return (theFile != null)
        ? CircleAvatar(
            backgroundColor: LightColors.kBlue,
            radius: 50.0,
            backgroundImage: FileImage(
              theFile!,
            ),
          )
        : CircleAvatar(
            backgroundColor: LightColors.kBlue,
            radius: 50.0,
            backgroundImage: AssetImage(
              'assets/images/avatar.png',
            ),
          );
  }
}
