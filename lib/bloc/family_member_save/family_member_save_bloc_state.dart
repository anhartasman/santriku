import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';

abstract class FamilyMemberSaveBlocState extends Equatable {
  const FamilyMemberSaveBlocState();
  @override
  List<Object> get props => [];
}

class FamilyMemberSaveOnIdle extends FamilyMemberSaveBlocState {
  const FamilyMemberSaveOnIdle();
}

class FamilyMemberSaveOnStarted extends FamilyMemberSaveBlocState {}

class FamilyMemberSaveOnSuccess extends FamilyMemberSaveBlocState {}

class FamilyMemberSaveOnError extends FamilyMemberSaveBlocState {
  final String errorMessage;
  FamilyMemberSaveOnError(this.errorMessage);
}
