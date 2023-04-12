import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';

abstract class StudentEvaluationSaveBlocState extends Equatable {
  const StudentEvaluationSaveBlocState();
  @override
  List<Object> get props => [];
}

class StudentEvaluationSaveOnIdle extends StudentEvaluationSaveBlocState {
  const StudentEvaluationSaveOnIdle();
}

class StudentEvaluationSaveOnStarted extends StudentEvaluationSaveBlocState {}

class StudentEvaluationSaveOnSuccess extends StudentEvaluationSaveBlocState {}

class StudentEvaluationSaveOnError extends StudentEvaluationSaveBlocState {
  final String errorMessage;
  StudentEvaluationSaveOnError(this.errorMessage);
}
