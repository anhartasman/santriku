import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/bloc/student_evaluation_history/student_evaluation_history_bloc.dart';
import 'package:santriku/bloc/student_evaluation_history/student_evaluation_history_bloc_event.dart';
import 'package:santriku/bloc/student_evaluation_save/student_evaluation_save_bloc.dart';
import 'package:santriku/bloc/pesantren_member_detail/bloc.dart';
import 'package:santriku/bloc/pesantren_member_save/pesantren_member_save_bloc.dart';
import 'package:santriku/helpers/extensions/ext_string.dart';
import 'package:santriku/routes/app_routes.dart';
import 'package:santriku/injection_container.dart' as di;
import 'package:santriku/screens/student_profile.dart';
import 'package:santriku/screens/evaluation_history.dart';
import 'package:santriku/screens/form_student.dart';
import 'package:santriku/screens/form_evaluation.dart';
import 'package:santriku/screens/home_page.dart';
import 'package:santriku/screens/report_evaluation.dart';
import 'package:santriku/screens/splash_screen.dart';
import 'package:santriku/theme/colors/Warna.dart';
import 'package:santriku/theme/colors/light_colors.dart';

final appPages = [
  GetPage(
    name: Routes.homeRoute,
    page: () => splash_screen(),
  ),
  GetPage(
    name: Routes.homeMenuRoute,
    page: () {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor:
      //       LightColors.kLightYellow, // navigation bar color
      //   statusBarColor: Warna.warnaUtama, // status bar color
      // ));
      return HomePage();
    },
  ),
  GetPage(
    name: Routes.formChildRoute,
    page: () => BlocProvider<PesantrenMemberSaveBloc>(
      create: (BuildContext context) => di.sl<PesantrenMemberSaveBloc>(),
      child: form_student(),
    ),
  ),
  GetPage(
    name: Routes.formEvaluationRoute,
    page: () {
      final studentId = Get.arguments["studentId"];
      return BlocProvider<StudentEvaluationSaveBloc>(
        create: (BuildContext context) => di.sl<StudentEvaluationSaveBloc>(),
        child: form_evaluation(
          studentId: studentId,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.reportEvaluationRoute,
    page: () {
      PesantrenMember theChild = Get.arguments;
      return MultiBlocProvider(
        providers: [
          BlocProvider<StudentEvaluationSaveBloc>(
              create: (BuildContext context) =>
                  di.sl<StudentEvaluationSaveBloc>()),
        ],
        child: report_evaluation(
          theChild: theChild,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.evaluationHistoryRoute,
    page: () {
      final studentId = Get.arguments["studentId"];
      final firstDate = Get.arguments["firstDate"] as DateTime;
      final lastDate = Get.arguments["lastDate"] as DateTime;
      print("search studentId $studentId");
      print("search firstDate $firstDate");
      print("search lastDate $lastDate");
      return MultiBlocProvider(
        providers: [
          BlocProvider<StudentEvaluationHistoryBloc>(
              create: (BuildContext context) =>
                  di.sl<StudentEvaluationHistoryBloc>()
                    ..add(StudentEvaluationHistoryBlocStart(
                        firstDate.toTanggal("yyyy-MM-dd"),
                        lastDate.toTanggal("yyyy-MM-dd")))),
        ],
        child: evaluation_history(
          studentId: studentId,
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.detailChildRoute,
    page: () {
      final id = Get.arguments["id"];
      final cardColor = Get.arguments["cardColor"] as Color;
      final circleColor = Get.arguments["circleColor"] as Color;
      return BlocProvider<PesantrenMemberDetailBloc>(
        create: (BuildContext context) => di.sl<PesantrenMemberDetailBloc>()
          ..add(PesantrenMemberDetailBlocRetrieve(id)),
        child: student_profile(
          cardColor: cardColor,
          circleColor: circleColor,
        ),
      );
    },
  ),
];
