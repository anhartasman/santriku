import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';

abstract class StudentEvaluationSaveBlocEvent {}

class StudentEvaluationSaveBlocStart extends StudentEvaluationSaveBlocEvent {
  final StudentEvaluation theEvaluation;
  StudentEvaluationSaveBlocStart(this.theEvaluation);
}
