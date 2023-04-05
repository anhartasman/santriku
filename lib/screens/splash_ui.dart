import 'package:flutter/material.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:saibupi/widgets/SplashContent.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SplashContent(),
      ),
    );
  }
}
