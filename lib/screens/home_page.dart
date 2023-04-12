import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/bloc/pesantren_member_detail/pesantren_member_detail_bloc.dart';
import 'package:santriku/bloc/pesantren_member_list/bloc.dart';
import 'package:santriku/bloc/pesantren_member_list/pesantren_member_list_bloc.dart';
import 'package:santriku/bloc/pesantren_member_list/pesantren_member_list_bloc_event.dart';
import 'package:santriku/helpers/colors/HexColor.dart';
import 'package:santriku/routes/app_routes.dart';
import 'package:santriku/screens/calendar_page.dart';
import 'package:santriku/screens/evaluation_child_page.dart';
import 'package:santriku/screens/form_student.dart';
import 'package:santriku/screens/image_slide.dart';
import 'package:santriku/theme/colors/Warna.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:santriku/widgets/TampilanDialog.dart';
import 'package:santriku/widgets/child_card.dart';
import 'package:santriku/widgets/task_column.dart';
import 'package:santriku/widgets/active_project_card.dart';
import 'package:santriku/widgets/top_container.dart';
import 'package:santriku/injection_container.dart' as di;

class HomePage extends StatefulWidget {
  static CircleAvatar calendarIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.calendar_today,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: LightColors.kLightYellow,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo_santriku.png",
                    height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(image_slide()),
                        child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFF8C7AE),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        "assets/images/book_lover.png")),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text("Image Slider",
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: InkWell(
                  onTap: () => Get.to(evaluation_child_page()),
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFF8AEAE),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                  "assets/images/thinking_face.png")),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text("Lembar Evaluasi",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
