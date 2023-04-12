import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

abstract class PesantrenRepository {
  Future<List<PesantrenMember>> memberList();
  Future<void> saveMember(PesantrenMember theMember);
  Future<PesantrenMember> memberDetail(int id);
  Future<void> saveEvaluation(StudentEvaluation theEvaluation);
  Future<List<StudentEvaluation>> evaluationResult(
      String firstDate, String lastDate);
}
