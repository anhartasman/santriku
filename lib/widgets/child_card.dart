import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/bloc/family_member_detail/bloc.dart';
import 'package:saibupi/bloc/family_member_list/bloc.dart';
import 'package:saibupi/routes/app_routes.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:saibupi/widgets/TampilanDialog.dart';

class ChildCard extends StatelessWidget {
  final Color cardColor;
  final Color circleColor;
  final FamilyMember initiatedMember;

  const ChildCard({
    required this.cardColor,
    required this.circleColor,
    required this.initiatedMember,
  });

  @override
  Widget build(BuildContext context) {
    // final childImage = decodeImageFromList(base64Decode(photo));
    FamilyMember theMember = initiatedMember;
    return BlocConsumer<FamilyMemberDetailBloc, FamilyMemberDetailBlocState>(
        listener: (context, state) {
      if (state is FamilyMemberDetailOnError && state.id == theMember.id) {
        TampilanDialog.showDialogAlert(state.errorMessage);
      }
    }, builder: (context, state) {
      if (state is FamilyMemberDetailOnStarted && state.id == theMember.id) {
        return Center(
          child: SpinKitWave(
            color: Warna.warnaUtama,
            size: 50.0,
          ),
        );
      }
      if (state is FamilyMemberDetailOnSuccess &&
          state.theMember.id == theMember.id) {
        theMember = state.theMember;
      }
      return Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => Get.toNamed(
            Routes.detailChildRoute,
            arguments: {
              "id": theMember.id,
              "cardColor": cardColor,
              "circleColor": circleColor,
            },
          )?.then((value) => BlocProvider.of<FamilyMemberDetailBloc>(context)
              .add(FamilyMemberDetailBlocRetrieve(theMember.id))),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(15.0),
            height: 200,
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularPercentIndicator(
                    radius: 40.0,
                    lineWidth: 5.0,
                    animation: true,
                    percent: 1,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: circleColor,
                    backgroundColor: Colors.white,
                    center: CircleAvatar(
                      backgroundColor: LightColors.kBlue,
                      radius: 35.0,
                      backgroundImage: FileImage(File(theMember.picture)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      theMember.name,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Anak ke ${theMember.childRank}",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
