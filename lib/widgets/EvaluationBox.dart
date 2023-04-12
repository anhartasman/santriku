import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:santriku/enums/enum_pertanyaan_evaluasi.dart';
import 'package:santriku/helpers/extensions/ext_string.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/calendar_dates.dart';

class EvaluationBox extends StatelessWidget {
  final PertanyaanEvaluasi thePertanyaanEvaluasi;
  final DateTime firstDate;
  final List<DateTime> tglList;
  final Color boxColor;
  const EvaluationBox({
    Key? key,
    required this.thePertanyaanEvaluasi,
    required this.tglList,
    required this.boxColor,
    required this.firstDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> allDate = [];
    List<bool> isian = [];
    int jumTerisi = 0;
    for (int i = 0; i < 7; i++) {
      final newDate = firstDate.add(Duration(days: i));
      allDate.add(newDate);
      final idxTgl =
          tglList.indexWhere((element) => element.day == newDate.day);
      final terisi = idxTgl > -1;
      isian.add(terisi);
      if (terisi) {
        jumTerisi += 1;
      }
    }
    final persentase = jumTerisi / 7;
    final labelPersentase = (persentase * 100).toStringAsFixed(0);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              thePertanyaanEvaluasi.label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
          ),
          SizedBox(height: 16.0),
          Wrap(
            children: List.generate(allDate.length, (index) {
              final String day = allDate[index].toTanggal("EEE");
              final String date = allDate[index].toTanggal("dd");
              final terisi = isian[index] == true;
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      day,
                      style: TextStyle(
                          fontSize: 16,
                          color: terisi ? Colors.black : Colors.grey,
                          fontWeight:
                              terisi ? FontWeight.bold : FontWeight.w400),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 16,
                          color: terisi ? Colors.black : Colors.grey,
                          fontWeight:
                              terisi ? FontWeight.bold : FontWeight.w700),
                    ),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: 16.0),
          Center(
            child: CircularPercentIndicator(
              radius: 35.0,
              lineWidth: 4.0,
              percent: persentase,
              center: Text(
                "${labelPersentase}%",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
