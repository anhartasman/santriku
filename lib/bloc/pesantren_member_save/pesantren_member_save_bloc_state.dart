import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

abstract class PesantrenMemberSaveBlocState extends Equatable {
  const PesantrenMemberSaveBlocState();
  @override
  List<Object> get props => [];
}

class PesantrenMemberSaveOnIdle extends PesantrenMemberSaveBlocState {
  const PesantrenMemberSaveOnIdle();
}

class PesantrenMemberSaveOnStarted extends PesantrenMemberSaveBlocState {}

class PesantrenMemberSaveOnSuccess extends PesantrenMemberSaveBlocState {}

class PesantrenMemberSaveOnError extends PesantrenMemberSaveBlocState {
  final String errorMessage;
  PesantrenMemberSaveOnError(this.errorMessage);
}
