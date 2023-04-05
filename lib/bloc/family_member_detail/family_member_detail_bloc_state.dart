import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';

abstract class FamilyMemberDetailBlocState extends Equatable {
  const FamilyMemberDetailBlocState();
  @override
  List<Object> get props => [];
}

class FamilyMemberDetailOnIdle extends FamilyMemberDetailBlocState {
  const FamilyMemberDetailOnIdle();
}

class FamilyMemberDetailOnStarted extends FamilyMemberDetailBlocState {
  final int id;
  const FamilyMemberDetailOnStarted(this.id);
}

class FamilyMemberDetailOnSuccess extends FamilyMemberDetailBlocState {
  final FamilyMember theMember;
  const FamilyMemberDetailOnSuccess(this.theMember);
}

class FamilyMemberDetailOnError extends FamilyMemberDetailBlocState {
  final int id;
  final String errorMessage;
  FamilyMemberDetailOnError(this.id, this.errorMessage);
}
