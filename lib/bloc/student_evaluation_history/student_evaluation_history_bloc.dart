import 'package:bloc/bloc.dart';
import 'package:santriku/architectures/domain/usecases/StudentEvaluationHistoryUseCase.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

import './bloc.dart';

class StudentEvaluationHistoryBloc extends Bloc<
    StudentEvaluationHistoryBlocEvent, StudentEvaluationHistoryBlocState> {
  final StudentEvaluationHistoryUseCase familyEvaluationHistoryUseCase;

  StudentEvaluationHistoryBloc({
    required this.familyEvaluationHistoryUseCase,
  }) : super(StudentEvaluationHistoryOnIdle()) {
    on<StudentEvaluationHistoryBlocEvent>((event, emit) async {
      if (event is StudentEvaluationHistoryBlocStart) {
        emit(StudentEvaluationHistoryOnStarted());
        final failureOrTrivia = await familyEvaluationHistoryUseCase(
            StudentEvaluationHistoryUseCaseParam(
                event.firstDate, event.lastDate));

        try {
          var resultList = await failureOrTrivia.first;

          emit(StudentEvaluationHistoryOnSuccess(resultList));
        } catch (e) {
          emit(StudentEvaluationHistoryOnError(e.toString()));
        }
      }
    });
  }
}
