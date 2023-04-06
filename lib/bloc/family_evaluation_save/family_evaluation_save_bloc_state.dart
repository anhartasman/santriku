import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';

abstract class FamilyEvaluationSaveBlocState extends Equatable {
  const FamilyEvaluationSaveBlocState();
  @override
  List<Object> get props => [];
}

class FamilyEvaluationSaveOnIdle extends FamilyEvaluationSaveBlocState {
  const FamilyEvaluationSaveOnIdle();
}

class FamilyEvaluationSaveOnStarted extends FamilyEvaluationSaveBlocState {}

class FamilyEvaluationSaveOnSuccess extends FamilyEvaluationSaveBlocState {}

class FamilyEvaluationSaveOnError extends FamilyEvaluationSaveBlocState {
  final String errorMessage;
  FamilyEvaluationSaveOnError(this.errorMessage);
}
