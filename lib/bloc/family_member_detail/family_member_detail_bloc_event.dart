abstract class FamilyMemberDetailBlocEvent {}

class FamilyMemberDetailBlocRetrieve extends FamilyMemberDetailBlocEvent {
  final int id;
  FamilyMemberDetailBlocRetrieve(this.id);
}
