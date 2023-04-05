import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saibupi/theme/colors/Warna.dart';

class ButtonMain extends StatelessWidget {
  final String tulisan;
  const ButtonMain(this.tulisan, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: kToolbarHeight - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Warna.WARNA_BIRU,
      ),
      child: Center(
        child: Text(tulisan,
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
