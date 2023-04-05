import 'package:flutter/material.dart';
import 'package:saibupi/theme/colors/light_colors.dart';

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Center(
            child: Text(
              "-Saibupi-",
              style: TextStyle(
                fontSize: 75,
                fontFamily: 'Anydore',
                color: Color(0xFFED6355),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Image.asset("assets/images/pana.png"),
      ],
    );
  }
}
