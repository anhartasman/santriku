import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/bloc/family_member_detail/bloc.dart';
import 'package:saibupi/bloc/family_member_list/bloc.dart';
import 'package:saibupi/bloc/family_member_list/family_member_list_bloc.dart';
import 'package:saibupi/bloc/family_member_list/family_member_list_bloc_event.dart';
import 'package:saibupi/routes/app_routes.dart';
import 'package:saibupi/screens/calendar_page.dart';
import 'package:saibupi/screens/form_child.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:saibupi/widgets/ShimmerHome.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';
import 'package:saibupi/widgets/child_card.dart';
import 'package:saibupi/widgets/task_column.dart';
import 'package:saibupi/widgets/active_project_card.dart';
import 'package:saibupi/widgets/top_container.dart';
import 'package:saibupi/injection_container.dart' as di;

class child_profile extends StatelessWidget {
  final Color cardColor;
  final Color circleColor;
  const child_profile({
    required this.cardColor,
    required this.circleColor,
  });
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

  static CircleAvatar plusIcon() {
    return CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.add,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: BlocConsumer<FamilyMemberDetailBloc, FamilyMemberDetailBlocState>(
          listener: (context, state) {
        if (state is FamilyMemberDetailOnError) {
          TampilanDialog.showDialogAlert(state.errorMessage);
        }
      }, builder: (context, state) {
        if (state is FamilyMemberDetailOnStarted) {
          return ShimmerHome();
        }
        if (state is FamilyMemberDetailOnSuccess) {
          final theMember = state.theMember;
          return Column(
            children: <Widget>[
              TopContainer(
                color: cardColor,
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        children: [
                          BackButton(color: Colors.white),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 5.0,
                              animation: true,
                              percent: 0.75,
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: circleColor,
                              backgroundColor: LightColors.kDarkYellow,
                              center: CircleAvatar(
                                backgroundColor: LightColors.kBlue,
                                radius: 35.0,
                                backgroundImage: FileImage(
                                  File(theMember.picture),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    theMember.name,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Anak ke ' + theMember.childRank.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ]),
              ),
              Expanded(
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  subheading('Menu Anak'),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               CalendarPage()),
                                  //     );
                                  //   },
                                  //   child: calendarIcon(),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 15.0),
                              TaskColumn(
                                icon: Icons.edit,
                                iconBackgroundColor: LightColors.kRed,
                                title: 'Evaluasi',
                                subtitle: 'Form Perkembangan Anak',
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              TaskColumn(
                                icon: Icons.calendar_month,
                                iconBackgroundColor: LightColors.kDarkYellow,
                                title: 'Laporan',
                                subtitle: 'Laporan Perkembangan Anak',
                              ),
                              SizedBox(height: 15.0),
                              InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.formChildRoute,
                                  arguments: theMember,
                                )?.then((value) {
                                  if (value == true) {
                                    BlocProvider.of<FamilyMemberDetailBloc>(
                                            context)
                                        .add(FamilyMemberDetailBlocRetrieve(
                                            theMember.id));
                                  }
                                }),
                                child: TaskColumn(
                                  icon: Icons.person,
                                  iconBackgroundColor: LightColors.kBlue,
                                  title: 'Data Diri',
                                  subtitle: 'Kelola Data Diri Anak',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      }),
    );
  }
}
