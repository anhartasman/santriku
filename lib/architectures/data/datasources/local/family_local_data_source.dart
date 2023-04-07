import 'package:saibupi/architectures/data/datasources/local/DbHelper.dart';
import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';

class FamilyLocalDataSource {
  static Future<List<FamilyMember>> memberList() async {
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectFamilyMember();
    return memberList;
  }

  static Future<void> saveMember(FamilyMember theMember) async {
    final DbHelper helper = DbHelper();
    if (theMember.id > 0) {
      await helper.updateFamilyMember(theMember);
    } else {
      await helper.insertFamilyMember(theMember);
    }
  }

  static Future<FamilyMember> memberDetail(int id) async {
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectFamilyMember(id: id);
    return memberList[0];
  }

  static Future<void> saveEvaluation(FamilyEvaluation theEvaluation) async {
    final DbHelper helper = DbHelper();
    final oldData =
        await helper.selectFamilyEvaluationByDate(theEvaluation.date);
    final newEvaluation = theEvaluation.copyWith(
        id: oldData.isEmpty ? theEvaluation.id : oldData[0].id);

    if (newEvaluation.id > 0) {
      await helper.updateFamilyEvaluation(newEvaluation);
    } else {
      await helper.insertFamilyEvaluation(newEvaluation);
    }
  }

  static Future<List<FamilyEvaluation>> evaluationResult(
      String firstDate, String lastDate) async {
    final DbHelper helper = DbHelper();
    final resultList =
        await helper.selectFamilyEvaluationByDateRange(firstDate, lastDate);
    return resultList;
  }
}
