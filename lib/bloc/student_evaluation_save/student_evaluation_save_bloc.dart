import 'package:bloc/bloc.dart';
import 'package:santriku/architectures/domain/usecases/StudentEvaluationSaveUseCase.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

import './bloc.dart';

class StudentEvaluationSaveBloc extends Bloc<StudentEvaluationSaveBlocEvent,
    StudentEvaluationSaveBlocState> {
  final StudentEvaluationSaveUseCase familyEvaluationSaveUseCase;

  StudentEvaluationSaveBloc({
    required this.familyEvaluationSaveUseCase,
  }) : super(StudentEvaluationSaveOnIdle()) {
    on<StudentEvaluationSaveBlocEvent>((event, emit) async {
      if (event is StudentEvaluationSaveBlocStart) {
        emit(StudentEvaluationSaveOnStarted());
        final failureOrTrivia =
            await familyEvaluationSaveUseCase(event.theEvaluation);

        try {
          var memberList = await failureOrTrivia.first;

          emit(StudentEvaluationSaveOnSuccess());
        } catch (e) {
          emit(StudentEvaluationSaveOnError(e.toString()));
        }
      }
    });
  }
}
