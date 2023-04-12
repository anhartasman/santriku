import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/dates_list.dart';
import 'package:santriku/enums/enum_pertanyaan_evaluasi.dart';
import 'package:santriku/theme/colors/Warna.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/EvaluationBox.dart';
import 'package:santriku/widgets/TampilanDialog.dart';
import 'package:santriku/widgets/calendar_dates.dart';

class DailyEvaluation extends StatelessWidget {
  final List<StudentEvaluation> evaluasiList;
  final DateTime firstDate;
  const DailyEvaluation({
    Key? key,
    required this.evaluasiList,
    required this.firstDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(PertanyaanEvaluasi.values.length, (index) {
            final thePertanyaanEvaluasi = PertanyaanEvaluasi.values[index];

            List<DateTime> tglList = [];

            final filteredResult = evaluasiList.where((element) {
              try {
                return element.answers[index] == 1;
              } catch (e) {
                return false;
              }
            });
            for (final theData in filteredResult) {
              tglList.add(DateTime.parse(theData.date));
            }
            late Color boxColor;
            if (tglList.isEmpty) {
              boxColor = LightColors.kPalePink;
            } else {
              if (tglList.length < 4) {
                boxColor = LightColors.kLavender;
              } else {
                boxColor = LightColors.kGreen;
              }
            }
            return EvaluationBox(
              thePertanyaanEvaluasi: thePertanyaanEvaluasi,
              tglList: tglList,
              boxColor: boxColor,
              firstDate: firstDate,
            );
          }),
        ),
      ],
    );
  }
}
