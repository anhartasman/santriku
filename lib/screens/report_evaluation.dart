import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/helpers/extensions/ext_string.dart';
import 'package:saibupi/routes/app_routes.dart';
import 'package:saibupi/screens/calendar_page.dart';
import 'package:saibupi/theme/colors/light_colors.dart';
import 'package:saibupi/widgets/top_container.dart';
import 'package:saibupi/widgets/back_button.dart';
import 'package:saibupi/widgets/my_text_field.dart';
import 'package:saibupi/screens/home_page.dart';

class report_evaluation extends StatefulWidget {
  final FamilyMember theChild;
  const report_evaluation({required this.theChild});

  @override
  State<report_evaluation> createState() => _report_evaluationState();
}

class _report_evaluationState extends State<report_evaluation> {
  final formKey = GlobalKey<FormBuilderState>();
  late DateTime today;
  late DateTime sunday;
  late DateTime saturday;
  late DateTime firstDate;
  late DateTime lastDate;
  Color selectedPeriodStartColor = Colors.blue;
  Color selectedPeriodLastColor = Colors.blue;
  Color selectedPeriodMiddleColor = Colors.blue;
  @override
  void initState() {
    today = DateTime.now();
    sunday = findFirstDateOfTheWeek(today);
    saturday = sunday.add(Duration(days: 6));
    firstDate = today.subtract(Duration(days: 365));
    lastDate = today.add(Duration(days: 365));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // defaults for styles
    selectedPeriodLastColor = Theme.of(context).colorScheme.secondary;
    selectedPeriodMiddleColor = Theme.of(context).colorScheme.secondary;
    selectedPeriodStartColor = Theme.of(context).colorScheme.secondary;
  }

  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return DateTime(
        dateTime.year, dateTime.month, dateTime.day - dateTime.weekday % 7);
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    DatePickerRangeStyles styles = DatePickerRangeStyles(
      selectedPeriodLastDecoration: BoxDecoration(
          color: selectedPeriodLastColor,
          borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10.0), bottomEnd: Radius.circular(10.0))),
      selectedPeriodStartDecoration: BoxDecoration(
        color: selectedPeriodStartColor,
        borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(10.0),
            bottomStart: Radius.circular(10.0)),
      ),
      displayedPeriodTitle: TextStyle(
        color: Colors.white,
      ),
      defaultDateTextStyle: TextStyle(
        color: Colors.white,
      ),
      dayHeaderStyle: DayHeaderStyle(
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      selectedPeriodMiddleDecoration: BoxDecoration(
          color: selectedPeriodMiddleColor, shape: BoxShape.rectangle),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          TopContainer(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 16),
            height: null,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Laporan Evaluasi',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WeekPicker(
                        datePickerLayoutSettings: DatePickerLayoutSettings(),
                        selectedDate: today,
                        onChanged: (DatePeriod datePeriod) {
                          sunday = datePeriod.start;
                          saturday = datePeriod.end;
                          setState(() {
                            today = datePeriod.start;
                          });
                        },
                        firstDate: firstDate,
                        lastDate: lastDate,
                        datePickerStyles: styles,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            width: width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                InkWell(
                  onTap: () =>
                      Get.toNamed(Routes.evaluationHistoryRoute, arguments: {
                    "childId": widget.theChild.id,
                    "firstDate": sunday,
                    "lastDate": saturday,
                  }),
                  child: Container(
                    child: Text(
                      'Cari Laporan',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: LightColors.kBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
