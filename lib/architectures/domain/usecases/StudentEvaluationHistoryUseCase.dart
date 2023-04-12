import 'dart:async';

import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

class StudentEvaluationHistoryUseCase extends UseCase<List<StudentEvaluation>,
    StudentEvaluationHistoryUseCaseParam> {
  StudentEvaluationHistoryUseCase(this.repository);

  final PesantrenRepository repository;

  @override
  Future<Stream<List<StudentEvaluation>>> call(
    StudentEvaluationHistoryUseCaseParam param,
  ) async {
    final StreamController<List<StudentEvaluation>> controller =
        StreamController();

    repository
        .evaluationResult(param.firstDate, param.lastDate)
        .then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}

class StudentEvaluationHistoryUseCaseParam {
  final String firstDate;
  final String lastDate;
  const StudentEvaluationHistoryUseCaseParam(this.firstDate, this.lastDate);
}
