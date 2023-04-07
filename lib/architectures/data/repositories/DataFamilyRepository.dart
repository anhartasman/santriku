import 'package:saibupi/architectures/data/datasources/local/DbHelper.dart';
import 'package:saibupi/architectures/data/datasources/local/family_local_data_source.dart';
import 'package:saibupi/architectures/domain/entities/FamilyEvaluation.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/architectures/domain/repositories/FamilyRepository.dart';
import 'package:logging/logging.dart';

class DataFamilyRepository implements FamilyRepository {
  late Logger _logger;

  DataFamilyRepository() {
    _logger = Logger('DataFamilyRepository');
  }

  @override
  Future<List<FamilyMember>> memberList() async {
    final memberList = await FamilyLocalDataSource.memberList();
    return memberList;
  }

  Future<void> saveMember(FamilyMember theMember) async {
    await FamilyLocalDataSource.saveMember(theMember);
  }

  Future<FamilyMember> memberDetail(int id) async {
    final theMember = await FamilyLocalDataSource.memberDetail(id);
    return theMember;
  }

  Future<void> saveEvaluation(FamilyEvaluation theEvaluation) async {
    await FamilyLocalDataSource.saveEvaluation(theEvaluation);
  }

  Future<List<FamilyEvaluation>> evaluationResult(
      String firstDate, String lastDate) async {
    final resultList =
        await FamilyLocalDataSource.evaluationResult(firstDate, lastDate);
    return resultList;
  }
}
