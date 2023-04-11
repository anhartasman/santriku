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
import 'package:saibupi/screens/form_child.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';
import 'package:saibupi/widgets/child_card.dart';
import 'package:saibupi/widgets/task_column.dart';
import 'package:saibupi/widgets/active_project_card.dart';
import 'package:saibupi/widgets/top_container.dart';
import 'package:saibupi/injection_container.dart' as di;

class evaluation_child_page extends StatelessWidget {
  const evaluation_child_page({super.key});

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
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider<FamilyMemberListBloc>(
                        create: (BuildContext context) =>
                            di.sl<FamilyMemberListBloc>()
                              ..add(FamilyMemberListBlocRetrieve())),
                    BlocProvider<FamilyMemberDetailBloc>(
                        create: (BuildContext context) =>
                            di.sl<FamilyMemberDetailBloc>()),
                  ],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _HeaderListAnak(),
                      SizedBox(height: 5.0),
                      BlocConsumer<FamilyMemberListBloc,
                              FamilyMemberListBlocState>(
                          listener: (context, state) {
                        if (state is FamilyMemberListOnError) {
                          TampilanDialog.showDialogAlert(state.errorMessage);
                        }
                      }, builder: (context, state) {
                        if (state is FamilyMemberListOnStarted) {
                          return Center(
                            child: SpinKitWave(
                              color: Warna.warnaUtama,
                              size: 50.0,
                            ),
                          );
                        }
                        final memberList = state.memberList;
                        if (memberList.isNotEmpty) {
                          final jumColumn = (memberList.length / 2).ceil();
                          Options options = Options(
                            format: Format.hex,
                            luminosity: Luminosity.dark,
                            colorType: ColorType.pink,
                            count: memberList.length,
                          );
                          var colors = RandomColor.getColor(options);
                          Options options2 = Options(
                            format: Format.hex,
                            luminosity: Luminosity.dark,
                            colorType: ColorType.yellow,
                            count: memberList.length,
                          );
                          var colors2 = RandomColor.getColor(options2);
                          for (final color in colors) {
                            print("warna " + color.toString());
                          }

                          return Column(
                            children: List.generate(jumColumn, (index) {
                              final firstIdx = index * 2;
                              final secondIdx = firstIdx + 1;
                              FamilyMember? child1;
                              FamilyMember? child2;
                              if (memberList.length > firstIdx) {
                                child1 = memberList[firstIdx];
                              }
                              if (memberList.length > secondIdx) {
                                child2 = memberList[secondIdx];
                              }
                              return Row(
                                children: [
                                  if (child1 != null)
                                    ChildCard(
                                      cardColor: HexColor(colors[firstIdx]),
                                      circleColor: HexColor(colors2[firstIdx]),
                                      initiatedMember: child1,
                                    ),
                                  if (child2 != null) SizedBox(width: 20),
                                  if (child2 != null)
                                    ChildCard(
                                      cardColor: HexColor(colors[secondIdx]),
                                      circleColor: HexColor(colors2[secondIdx]),
                                      initiatedMember: child2,
                                    ),
                                  if (child2 == null)
                                    Expanded(
                                      child: Container(),
                                    ),
                                ],
                              );
                            }),
                          );
                        }

                        return Container();
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderListAnak extends StatelessWidget {
  const _HeaderListAnak({super.key});

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        subheading('Daftar Anak'),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.formChildRoute)?.then((value) {
            if (value == true) {
              BlocProvider.of<FamilyMemberListBloc>(context)
                  .add(FamilyMemberListBlocRetrieve());
            }
          }),
          child: plusIcon(),
        ),
      ],
    );
  }
}
