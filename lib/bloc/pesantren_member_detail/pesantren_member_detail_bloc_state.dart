import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

abstract class PesantrenMemberDetailBlocState extends Equatable {
  const PesantrenMemberDetailBlocState();
  @override
  List<Object> get props => [];
}

class PesantrenMemberDetailOnIdle extends PesantrenMemberDetailBlocState {
  const PesantrenMemberDetailOnIdle();
}

class PesantrenMemberDetailOnStarted extends PesantrenMemberDetailBlocState {
  final int id;
  const PesantrenMemberDetailOnStarted(this.id);
}

class PesantrenMemberDetailOnSuccess extends PesantrenMemberDetailBlocState {
  final PesantrenMember theMember;
  const PesantrenMemberDetailOnSuccess(this.theMember);
}

class PesantrenMemberDetailOnError extends PesantrenMemberDetailBlocState {
  final int id;
  final String errorMessage;
  PesantrenMemberDetailOnError(this.id, this.errorMessage);
}
