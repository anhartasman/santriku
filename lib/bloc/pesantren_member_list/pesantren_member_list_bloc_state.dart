import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

abstract class PesantrenMemberListBlocState extends Equatable {
  final List<PesantrenMember> memberList;
  const PesantrenMemberListBlocState({this.memberList = const []});
  @override
  List<Object> get props => [memberList];
}

class PesantrenMemberListOnIdle extends PesantrenMemberListBlocState {
  const PesantrenMemberListOnIdle();
}

class PesantrenMemberListOnStarted extends PesantrenMemberListBlocState {}

class PesantrenMemberListOnSuccess extends PesantrenMemberListBlocState {
  final List<PesantrenMember> memberList;
  const PesantrenMemberListOnSuccess(this.memberList)
      : super(memberList: memberList);
}

class PesantrenMemberListOnError extends PesantrenMemberListBlocState {
  final String errorMessage;
  PesantrenMemberListOnError(this.errorMessage);
}
