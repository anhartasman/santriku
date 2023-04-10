import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_randomcolor/flutter_randomcolor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/bloc/family_member_detail/family_member_detail_bloc.dart';
import 'package:saibupi/bloc/family_member_list/bloc.dart';
import 'package:saibupi/bloc/family_member_list/family_member_list_bloc.dart';
import 'package:saibupi/bloc/family_member_list/family_member_list_bloc_event.dart';
import 'package:saibupi/helpers/colors/HexColor.dart';
import 'package:saibupi/routes/app_routes.dart';
import 'package:saibupi/screens/calendar_page.dart';
import 'package:saibupi/screens/evaluation_child_page.dart';
import 'package:saibupi/screens/form_child.dart';
import 'package:saibupi/screens/read_penggunaan_gadget.dart';
import 'package:saibupi/screens/read_tips_solusi.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';
import 'package:saibupi/widgets/child_card.dart';
import 'package:saibupi/widgets/task_column.dart';
import 'package:saibupi/widgets/active_project_card.dart';
import 'package:saibupi/widgets/top_container.dart';
import 'package:saibupi/injection_container.dart' as di;

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
                    "assets/images/logo_saibupi.png",
                    height: 100,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      color: Color(0xFF455A64),
                    ),
                    child: Text("Halaman Menu",
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(read_tips_solusi()),
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
                                  child: Text("Tips & Solusi",
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
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.to(read_penggunaan_gadget()),
                        child: Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFAEDBF8),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(
                                        "assets/images/online_tech.png")),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text("Pemanfaatan Gadget",
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
