import 'dart:async';

import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

class StudentEvaluationSaveUseCase extends UseCase<void, StudentEvaluation> {
  StudentEvaluationSaveUseCase(this.repository);

  final PesantrenRepository repository;

  @override
  Future<Stream<void>> call(
    StudentEvaluation theEvaluation,
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
