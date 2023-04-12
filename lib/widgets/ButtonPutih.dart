import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:santriku/theme/colors/Warna.dart';

class ButtonPutih extends StatelessWidget {
  final String tulisan;
  const ButtonPutih(this.tulisan, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: kToolbarHeight - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.white,
        border: Border.all(
          color: Warna.WARNA_BIRU,
        ),
      ),
      child: Center(
        child: Text(tulisan,
            style: TextStyle(
                fontSize: 16,
                color: Warna.warnaUtama,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
