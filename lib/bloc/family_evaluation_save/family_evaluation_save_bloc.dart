import 'package:bloc/bloc.dart';
import 'package:saibupi/architectures/domain/usecases/FamilyEvaluationSaveUseCase.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

import './bloc.dart';

class FamilyEvaluationSaveBloc
    extends Bloc<FamilyEvaluationSaveBlocEvent, FamilyEvaluationSaveBlocState> {
  final FamilyEvaluationSaveUseCase familyEvaluationSaveUseCase;

  FamilyEvaluationSaveBloc({
    required this.familyEvaluationSaveUseCase,
  }) : super(FamilyEvaluationSaveOnIdle()) {
    on<FamilyEvaluationSaveBlocEvent>((event, emit) async {
      if (event is FamilyEvaluationSaveBlocStart) {
        emit(FamilyEvaluationSaveOnStarted());
        final failureOrTrivia =
            await familyEvaluationSaveUseCase(event.theEvaluation);

        try {
          var memberList = await failureOrTrivia.first;

          emit(FamilyEvaluationSaveOnSuccess());
        } catch (e) {
          emit(FamilyEvaluationSaveOnError(e.toString()));
        }
      }
    });
  }
}
