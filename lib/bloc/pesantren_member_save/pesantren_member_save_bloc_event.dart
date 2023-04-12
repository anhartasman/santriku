import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

abstract class PesantrenMemberSaveBlocEvent {}

class PesantrenMemberSaveBlocStart extends PesantrenMemberSaveBlocEvent {
  final PesantrenMember theMember;
  PesantrenMemberSaveBlocStart(this.theMember);
}
