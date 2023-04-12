import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:santriku/bloc/pesantren_member_detail/bloc.dart';
import 'package:santriku/routes/app_routes.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/ShimmerHome.dart';
import 'package:santriku/widgets/TampilanDialog.dart';
import 'package:santriku/widgets/task_column.dart';
import 'package:santriku/widgets/top_container.dart';

class student_profile extends StatelessWidget {
  final Color cardColor;
  final Color circleColor;
  const student_profile({
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
      body: BlocConsumer<PesantrenMemberDetailBloc,
          PesantrenMemberDetailBlocState>(listener: (context, state) {
        if (state is PesantrenMemberDetailOnError) {
          TampilanDialog.showDialogAlert(state.errorMessage);
        }
      }, builder: (context, state) {
        if (state is PesantrenMemberDetailOnStarted) {
          return ShimmerHome();
        }
        if (state is PesantrenMemberDetailOnSuccess) {
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
                                    'kelas ' +
                                        theMember.studentClass.toString(),
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
                                  subheading('Menu Santri'),
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
                              InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.formEvaluationRoute,
                                  arguments: {"studentId": theMember.id},
                                )?.then((value) {
                                  if (value == true) {
                                    BlocProvider.of<PesantrenMemberDetailBloc>(
                                            context)
                                        .add(PesantrenMemberDetailBlocRetrieve(
                                            theMember.id));
                                  }
                                }),
                                child: TaskColumn(
                                  icon: Icons.edit,
                                  iconBackgroundColor: LightColors.kRed,
                                  title: 'Evaluasi',
                                  subtitle: 'Form Perkembangan Santri',
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.reportEvaluationRoute,
                                  arguments: theMember,
                                )?.then((value) {
                                  if (value == true) {
                                    BlocProvider.of<PesantrenMemberDetailBloc>(
                                            context)
                                        .add(PesantrenMemberDetailBlocRetrieve(
                                            theMember.id));
                                  }
                                }),
                                child: TaskColumn(
                                  icon: Icons.calendar_month,
                                  iconBackgroundColor: LightColors.kDarkYellow,
                                  title: 'Laporan',
                                  subtitle: 'Laporan Perkembangan Santri',
                                ),
                              ),
                              SizedBox(height: 15.0),
                              InkWell(
                                onTap: () => Get.toNamed(
                                  Routes.formChildRoute,
                                  arguments: theMember,
                                )?.then((value) {
                                  if (value == true) {
                                    BlocProvider.of<PesantrenMemberDetailBloc>(
                                            context)
                                        .add(PesantrenMemberDetailBlocRetrieve(
                                            theMember.id));
                                  }
                                }),
                                child: TaskColumn(
                                  icon: Icons.person,
                                  iconBackgroundColor: LightColors.kBlue,
                                  title: 'Data Diri',
                                  subtitle: 'Kelola Data Diri Santri',
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
