import 'package:flutter/material.dart';
import 'package:saibupi/theme/colors/light_colors.dart';

class SplashContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Center(
            child: Image.asset(
              "assets/images/logo_saibupi.png",
              height: 100,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(18)),
                color: Color(0xFF455A64),
              ),
              child: Text("Aplikasi Ibu Pintar",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(18)),
                color: Color(0xFF455A64),
              ),
              child: Text("Mendampingi Anak di Era digital",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
        Image.asset(
          "assets/images/pana.png",
          height: appHeight * 0.4,
        ),
      ],
    );
  }
}
