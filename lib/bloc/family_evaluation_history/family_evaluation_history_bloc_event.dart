import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';

abstract class FamilyEvaluationHistoryBlocEvent {}

class FamilyEvaluationHistoryBlocStart
    extends FamilyEvaluationHistoryBlocEvent {
  final String firstDate;
  final String lastDate;
  FamilyEvaluationHistoryBlocStart(this.firstDate, this.lastDate);
}
