import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/bloc/family_evaluation_save/family_evaluation_save_bloc.dart';
import 'package:saibupi/bloc/family_member_detail/bloc.dart';
import 'package:saibupi/bloc/family_member_save/family_member_save_bloc.dart';
import 'package:saibupi/routes/app_routes.dart';
import 'package:saibupi/injection_container.dart' as di;
import 'package:saibupi/screens/child_profile.dart';
import 'package:saibupi/screens/form_child.dart';
import 'package:saibupi/screens/form_evaluation.dart';
import 'package:saibupi/screens/home_page.dart';
import 'package:saibupi/screens/report_evaluation.dart';
import 'package:saibupi/screens/splash_screen.dart';
import 'package:saibupi/theme/colors/Warna.dart';
import 'package:saibupi/theme/colors/light_colors.dart';

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
    page: () => BlocProvider<FamilyMemberSaveBloc>(
      create: (BuildContext context) => di.sl<FamilyMemberSaveBloc>(),
      child: form_child(),
    ),
  ),
  GetPage(
    name: Routes.formEvaluationRoute,
    page: () {
      final childId = Get.arguments["childId"];
      return BlocProvider<FamilyEvaluationSaveBloc>(
        create: (BuildContext context) => di.sl<FamilyEvaluationSaveBloc>(),
        child: form_evaluation(
          childId: childId,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.reportEvaluationRoute,
    page: () {
      FamilyMember theChild = Get.arguments;
      return MultiBlocProvider(
        providers: [
          BlocProvider<FamilyEvaluationSaveBloc>(
              create: (BuildContext context) =>
                  di.sl<FamilyEvaluationSaveBloc>()),
        ],
        child: report_evaluation(
          theChild: theChild,
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
      return BlocProvider<FamilyMemberDetailBloc>(
        create: (BuildContext context) => di.sl<FamilyMemberDetailBloc>()
          ..add(FamilyMemberDetailBlocRetrieve(id)),
        child: child_profile(
          cardColor: cardColor,
          circleColor: circleColor,
        ),
      );
    },
  ),
];
