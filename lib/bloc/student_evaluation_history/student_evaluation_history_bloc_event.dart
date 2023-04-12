import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';

abstract class StudentEvaluationHistoryBlocEvent {}

class StudentEvaluationHistoryBlocStart
    extends StudentEvaluationHistoryBlocEvent {
  final String firstDate;
  final String lastDate;
  StudentEvaluationHistoryBlocStart(this.firstDate, this.lastDate);
}
