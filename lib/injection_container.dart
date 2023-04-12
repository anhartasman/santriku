import 'package:santriku/architectures/data/repositories/DataPesantrenRepository.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/domain/usecases/StudentEvaluationHistoryUseCase.dart';
import 'package:santriku/architectures/domain/usecases/StudentEvaluationSaveUseCase.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberDetailUseCase.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberListUseCase.dart';
import 'package:get_it/get_it.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberSaveUseCase.dart';
import 'package:santriku/bloc/student_evaluation_history/student_evaluation_history_bloc.dart';
import 'package:santriku/bloc/student_evaluation_save/student_evaluation_save_bloc.dart';
import 'package:santriku/bloc/pesantren_member_detail/pesantren_member_detail_bloc.dart';
import 'package:santriku/bloc/pesantren_member_list/pesantren_member_list_bloc.dart';
import 'package:santriku/bloc/pesantren_member_save/pesantren_member_save_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => PesantrenMemberListUseCase(sl()));
  sl.registerLazySingleton(() => PesantrenMemberSaveUseCase(sl()));
  sl.registerLazySingleton(() => PesantrenMemberDetailUseCase(sl()));
  sl.registerLazySingleton(() => StudentEvaluationSaveUseCase(sl()));
  sl.registerLazySingleton(() => StudentEvaluationHistoryUseCase(sl()));
  // Repository
  sl.registerLazySingleton<PesantrenRepository>(
    () => DataPesantrenRepository(),
  );
  sl.registerFactory(
    () => PesantrenMemberListBloc(
      pesantrenMemberListUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => PesantrenMemberSaveBloc(
      pesantrenMemberSaveUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => PesantrenMemberDetailBloc(
      pesantrenMemberDetailUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => StudentEvaluationSaveBloc(
      familyEvaluationSaveUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => StudentEvaluationHistoryBloc(
      familyEvaluationHistoryUseCase: sl(),
    ),
  );
}
