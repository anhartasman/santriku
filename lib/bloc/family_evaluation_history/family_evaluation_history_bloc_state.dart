import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';

abstract class FamilyEvaluationHistoryBlocState extends Equatable {
  const FamilyEvaluationHistoryBlocState();
  @override
  List<Object> get props => [];
}

class FamilyEvaluationHistoryOnIdle extends FamilyEvaluationHistoryBlocState {
  const FamilyEvaluationHistoryOnIdle();
}

class FamilyEvaluationHistoryOnStarted
    extends FamilyEvaluationHistoryBlocState {}

class FamilyEvaluationHistoryOnSuccess
    extends FamilyEvaluationHistoryBlocState {
  final List<FamilyEvaluation> resultList;
  const FamilyEvaluationHistoryOnSuccess(this.resultList);
}

class FamilyEvaluationHistoryOnError extends FamilyEvaluationHistoryBlocState {
  final String errorMessage;
  FamilyEvaluationHistoryOnError(this.errorMessage);
}
