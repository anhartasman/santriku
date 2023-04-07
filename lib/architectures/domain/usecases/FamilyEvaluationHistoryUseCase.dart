import 'dart:async';

import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/architectures/domain/repositories/FamilyRepository.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

class FamilyEvaluationHistoryUseCase extends UseCase<List<FamilyEvaluation>,
    FamilyEvaluationHistoryUseCaseParam> {
  FamilyEvaluationHistoryUseCase(this.repository);

  final FamilyRepository repository;

  @override
  Future<Stream<List<FamilyEvaluation>>> call(
    FamilyEvaluationHistoryUseCaseParam param,
  ) async {
    final StreamController<List<FamilyEvaluation>> controller =
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

class FamilyEvaluationHistoryUseCaseParam {
  final String firstDate;
  final String lastDate;
  const FamilyEvaluationHistoryUseCaseParam(this.firstDate, this.lastDate);
}
