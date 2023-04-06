import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';

abstract class FamilyRepository {
  Future<List<FamilyMember>> memberList();
  Future<void> saveMember(FamilyMember theMember);
  Future<FamilyMember> memberDetail(int id);
  Future<void> saveEvaluation(FamilyEvaluation theEvaluation);
}
