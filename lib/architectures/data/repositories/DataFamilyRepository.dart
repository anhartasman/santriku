import 'package:saibupi/architectures/data/datasources/local/DbHelper.dart';
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
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectFamilyMember();
    return memberList;
  }

  Future<void> saveMember(FamilyMember theMember) async {
    final DbHelper helper = DbHelper();
    if (theMember.id > 0) {
      await helper.updateFamilyMember(theMember);
    } else {
      await helper.insertFamilyMember(theMember);
    }
  }

  Future<FamilyMember> memberDetail(int id) async {
    final DbHelper helper = DbHelper();
    final memberList = await helper.selectFamilyMember(id: id);
    return memberList[0];
  }
}
