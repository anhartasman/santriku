import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santriku/bloc/student_evaluation_history/bloc.dart';
import 'package:santriku/dates_list.dart';
import 'package:santriku/enums/enum_pertanyaan_evaluasi.dart';
import 'package:santriku/helpers/extensions/ext_string.dart';
import 'package:santriku/theme/colors/light_colors.dart';
import 'package:santriku/widgets/DailyEvaluation.dart';
import 'package:santriku/widgets/EvaluationBox.dart';
import 'package:santriku/widgets/ShimmerHome.dart';
import 'package:santriku/widgets/TampilanDialog.dart';
import 'package:santriku/widgets/calendar_dates.dart';
import 'package:santriku/widgets/task_container.dart';
import 'package:santriku/screens/create_new_task_page.dart';
import 'package:santriku/widgets/back_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class evaluation_history extends StatelessWidget {
  final int studentId;
  final DateTime firstDate;
  final DateTime lastDate;
  const evaluation_history({
    required this.studentId,
    required this.firstDate,
    required this.lastDate,
  });
  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> tglList = [];
    List<DateTime> dateList = [];
    for (int i = firstDate.day; i < firstDate.day + 7; i++) {
      tglList.add(i);
    }
    for (int i = 0; i < 7; i++) {
      dateList.add(firstDate.add(Duration(days: i)));
    }
    return Scaffold(
      backgroundColor: LightColors.kLightYellow,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),
          child: BlocConsumer<StudentEvaluationHistoryBloc,
              StudentEvaluationHistoryBlocState>(listener: (context, state) {
            if (state is StudentEvaluationHistoryOnError) {
              TampilanDialog.showDialogAlert(state.errorMessage);
            }
          }, builder: (context, state) {
            if (state is StudentEvaluationHistoryOnStarted) {
              return ShimmerHome();
            }
            if (state is StudentEvaluationHistoryOnSuccess) {
              return ListView(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Laporan Mingguan',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${firstDate.toTanggal("EEEE, dd MMM")} - ${lastDate.toTanggal("EEEE, dd MMM")}",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 10),
                  SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: 'Grafik'),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      series: <LineSeries<_statisticData, String>>[
                        LineSeries<_statisticData, String>(
                            isVisibleInLegend: false,
                            dataSource: List.generate(tglList.length, (index) {
                              final theDate = dateList[index];
                              final theDateData = state.resultList
                                  .where((element) =>
                                      DateTime.parse(element.date) == theDate)
                                  .toList();
                              return _statisticData(
                                  theDate, theDateData.length);
                            }),
                            xValueMapper: (_statisticData sales, _) =>
                                sales.date.toTanggal("EEE, dd"),
                            yValueMapper: (_statisticData sales, _) =>
                                sales.count,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                  SizedBox(height: 16),
                  DailyEvaluation(
                    evaluasiList: state.resultList,
                    firstDate: firstDate,
                  ),
                ],
              );
            }
            return Container();
          }),
        ),
      ),
    );
  }
}

class _statisticData {
  final DateTime date;
  final int count;
  const _statisticData(this.date, this.count);
}
