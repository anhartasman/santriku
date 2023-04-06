import 'dart:async';

import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/architectures/domain/repositories/FamilyRepository.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

class FamilyEvaluationSaveUseCase extends UseCase<void, FamilyEvaluation> {
  FamilyEvaluationSaveUseCase(this.repository);

  final FamilyRepository repository;

  @override
  Future<Stream<void>> call(
    FamilyEvaluation theEvaluation,
  ) async {
    final StreamController<void> controller = StreamController();

    repository.saveEvaluation(theEvaluation).then((the_respon) {
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
