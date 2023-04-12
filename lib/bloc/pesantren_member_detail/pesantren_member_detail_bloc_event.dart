abstract class PesantrenMemberDetailBlocEvent {}

class PesantrenMemberDetailBlocRetrieve extends PesantrenMemberDetailBlocEvent {
  final int id;
  PesantrenMemberDetailBlocRetrieve(this.id);
}
