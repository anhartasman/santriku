import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:santriku/routes/app_routes.dart';
import 'package:santriku/screens/SplashCheckPermission.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/SplashContent.dart';

class splash_screen extends StatefulWidget {
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  bool needPermission = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (needPermission) {
      // checkUserPermission();
      return SplashCheckPermission(
          onSuccess: () => setState(() => needPermission = false));
    }

    Future.delayed(Duration(milliseconds: 500))
        .then((value) => Get.offNamed(Routes.homeMenuRoute));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SplashContent(),
            ),
          ],
        ),
      ),
    );
  }
}
