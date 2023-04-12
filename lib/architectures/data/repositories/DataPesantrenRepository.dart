import 'package:santriku/architectures/data/datasources/local/DbHelper.dart';
import 'package:santriku/architectures/data/datasources/local/pesantren_local_data_source.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:logging/logging.dart';

class DataPesantrenRepository implements PesantrenRepository {
  late Logger _logger;

  DataPesantrenRepository() {
    _logger = Logger('DataPesantrenRepository');
  }

  @override
  Future<List<PesantrenMember>> memberList() async {
    final memberList = await PesantrenLocalDataSource.memberList();
    return memberList;
  }

  Future<void> saveMember(PesantrenMember theMember) async {
    await PesantrenLocalDataSource.saveMember(theMember);
  }

  Future<PesantrenMember> memberDetail(int id) async {
    final theMember = await PesantrenLocalDataSource.memberDetail(id);
    return theMember;
  }

  Future<void> saveEvaluation(StudentEvaluation theEvaluation) async {
    await PesantrenLocalDataSource.saveEvaluation(theEvaluation);
  }

  Future<List<StudentEvaluation>> evaluationResult(
      String firstDate, String lastDate) async {
    final resultList =
        await PesantrenLocalDataSource.evaluationResult(firstDate, lastDate);
    return resultList;
  }
}
