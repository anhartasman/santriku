import 'package:santriku/architectures/data/datasources/local/DbHelper.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';

class PesantrenLocalDataSource {
  static Future<List<PesantrenMember>> memberList() async {
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectPesantrenMember();
    return memberList;
  }

  static Future<void> saveMember(PesantrenMember theMember) async {
    final DbHelper helper = DbHelper();
    if (theMember.id > 0) {
      await helper.updatePesantrenMember(theMember);
    } else {
      await helper.insertPesantrenMember(theMember);
    }
  }

  static Future<PesantrenMember> memberDetail(int id) async {
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectPesantrenMember(id: id);
    return memberList[0];
  }

  static Future<void> saveEvaluation(StudentEvaluation theEvaluation) async {
    final DbHelper helper = DbHelper();
    final oldData =
        await helper.selectStudentEvaluationByDate(theEvaluation.date);
    final newEvaluation = theEvaluation.copyWith(
        id: oldData.isEmpty ? theEvaluation.id : oldData[0].id);

    if (newEvaluation.id > 0) {
      await helper.updateStudentEvaluation(newEvaluation);
    } else {
      await helper.insertStudentEvaluation(newEvaluation);
    }
  }

  static Future<List<StudentEvaluation>> evaluationResult(
      String firstDate, String lastDate) async {
    final DbHelper helper = DbHelper();
    final resultList =
        await helper.selectStudentEvaluationByDateRange(firstDate, lastDate);
    return resultList;
  }
}
