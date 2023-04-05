import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';

abstract class FamilyMemberListBlocState extends Equatable {
  final List<FamilyMember> memberList;
  const FamilyMemberListBlocState({this.memberList = const []});
  @override
  List<Object> get props => [memberList];
}

class FamilyMemberListOnIdle extends FamilyMemberListBlocState {
  const FamilyMemberListOnIdle();
}

class FamilyMemberListOnStarted extends FamilyMemberListBlocState {}

class FamilyMemberListOnSuccess extends FamilyMemberListBlocState {
  final List<FamilyMember> memberList;
  const FamilyMemberListOnSuccess(this.memberList)
      : super(memberList: memberList);
}

class FamilyMemberListOnError extends FamilyMemberListBlocState {
  final String errorMessage;
  FamilyMemberListOnError(this.errorMessage);
}
