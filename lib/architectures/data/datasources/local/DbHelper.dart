import 'dart:io';

import 'package:saibupi/architectures/data/datasources/local/queries/MemberQuery.dart';
import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //membuat method singleton
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  final tables = [
    MemberQuery.CREATE_TABLE,
  ]; // membuat daftar table yang akan dibuat

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'contact.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    for (final table in tables) {
      await db.execute(table).then((value) {
        print("berhasil ");
      }).catchError((err) {
        print("errornya ${err.toString()}");
      });
    }
  }

  Future<List<FamilyMember>> selectFamilyMember({int? id}) async {
    final db = await initDb();
    final result = await db.query(
      MemberQuery.TABLE_NAME,
      where: id == null ? null : "id=?",
      whereArgs: id == null ? null : [id],
      orderBy: 'childRank',
    );

    List<FamilyMember> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      var rowAbsen = FamilyMember.fromMap(newMap);

      theRespon.add(rowAbsen);
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

//create databases
  Future<int> insertFamilyMember(FamilyMember object) async {
    final db = await initDb();
    var theMap = object.toMap();
    theMap["id"] = null;
    int count = await db.insert(MemberQuery.TABLE_NAME, theMap);
    return count;
  }

//update databases
  Future<int> updateFamilyMember(FamilyMember object) async {
    final db = await initDb();
    int count = await db.update(MemberQuery.TABLE_NAME, object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    final db = await initDb();
    int count =
        await db.delete(MemberQuery.TABLE_NAME, where: 'id=?', whereArgs: [id]);
    return count;
  }
}
