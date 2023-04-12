import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:santriku/theme/colors/light_colors.dart';

class view_zoom_image extends StatelessWidget {
  final String theImage;
  const view_zoom_image(this.theImage, {super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      // backgroundColor: Colors.white,
      body: PhotoView(
        maxScale: 0.9,
        // minScale: 0.5,
        minScale: PhotoViewComputedScale.contained * 0.8,
        imageProvider: AssetImage(theImage),
      ),
    );
  }
}
