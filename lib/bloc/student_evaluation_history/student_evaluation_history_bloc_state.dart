import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';

abstract class StudentEvaluationHistoryBlocState extends Equatable {
  const StudentEvaluationHistoryBlocState();
  @override
  List<Object> get props => [];
}

class StudentEvaluationHistoryOnIdle extends StudentEvaluationHistoryBlocState {
  const StudentEvaluationHistoryOnIdle();
}

class StudentEvaluationHistoryOnStarted
    extends StudentEvaluationHistoryBlocState {}

class StudentEvaluationHistoryOnSuccess
    extends StudentEvaluationHistoryBlocState {
  final List<StudentEvaluation> resultList;
  const StudentEvaluationHistoryOnSuccess(this.resultList);
}

class StudentEvaluationHistoryOnError
    extends StudentEvaluationHistoryBlocState {
  final String errorMessage;
  StudentEvaluationHistoryOnError(this.errorMessage);
}
