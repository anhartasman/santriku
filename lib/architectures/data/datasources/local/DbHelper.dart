import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:santriku/architectures/data/datasources/local/queries/EvaluationQuery.dart';
import 'package:santriku/architectures/data/datasources/local/queries/StudentQuery.dart';
import 'package:santriku/architectures/domain/entities/StudentEvaluation.dart';
import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DbHelper {
  //membuat method singleton
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  final tables = [
    StudentQuery.CREATE_TABLE,
    EvaluationQuery.createTable(),
  ]; // membuat daftar table yang akan dibuat

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    String path = "";
    if (kIsWeb) {
      path = 'santriku.db';
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path + 'santriku.db';
    }
    //create, read databases
    var factory = databaseFactoryFfiWeb;
    late Future<Database> todoDatabase;
    if (kIsWeb) {
      todoDatabase = factory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 4,
          onCreate: _createDb,
          onUpgrade: _onUpgradeDB,
        ),
      );
    } else {
      todoDatabase = openDatabase(path,
          version: 4, onCreate: _createDb, onUpgrade: _onUpgradeDB);
    }

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

  void _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    for (final table in tables) {
      await db.execute(table).then((value) {
        print("berhasil ");
      }).catchError((err) {
        print("errornya ${err.toString()}");
      });
    }
  }

  Future<List<PesantrenMember>> selectPesantrenMember({int? id}) async {
    final db = await initDb();
    final result = await db.query(
      StudentQuery.TABLE_NAME,
      where: id == null ? null : "id=?",
      whereArgs: id == null ? null : [id],
      orderBy: 'studentClass',
    );

    List<PesantrenMember> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      var rowAbsen = PesantrenMember.fromMap(newMap);

      theRespon.add(rowAbsen);
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

//create databases
  Future<int> insertPesantrenMember(PesantrenMember object) async {
    final db = await initDb();
    var theMap = object.toMap();
    theMap.remove("id");
    int count = await db.insert(StudentQuery.TABLE_NAME, theMap);
    return count;
  }

//update databases
  Future<int> updatePesantrenMember(PesantrenMember object) async {
    final db = await initDb();
    int count = await db.update(StudentQuery.TABLE_NAME, object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> insertStudentEvaluation(StudentEvaluation object) async {
    final db = await initDb();
    var theMap = evaluationMap(object);
    theMap.remove("id");
    int count = await db.insert(EvaluationQuery.TABLE_NAME, theMap);
    return count;
  }

  Future<int> updateStudentEvaluation(StudentEvaluation object) async {
    final db = await initDb();
    var theMap = evaluationMap(object);
    int count = await db.update(EvaluationQuery.TABLE_NAME, theMap,
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Map<String, dynamic> evaluationMap(StudentEvaluation theEvaluation) {
    var theMap = theEvaluation.toMap();
    theEvaluation.answers.asMap().forEach((key, value) {
      theMap["pertanyaan${key}"] = value;
    });
    theMap.remove("answers");
    print("hasil konvert " + theMap.toString());
    return theMap;
  }

  Future<List<StudentEvaluation>> selectStudentEvaluation({int? id}) async {
    final db = await initDb();
    final result = await db.query(
      EvaluationQuery.TABLE_NAME,
      where: id == null ? null : "id=?",
      whereArgs: id == null ? null : [id],
      orderBy: 'id',
    );

    List<StudentEvaluation> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      theRespon.add(evaluationFromMap(newMap));
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

  Future<List<StudentEvaluation>> selectStudentEvaluationByDate(
      String date) async {
    final db = await initDb();
    final result = await db.query(
      EvaluationQuery.TABLE_NAME,
      where: "date=?",
      whereArgs: [date],
      orderBy: 'id',
    );

    List<StudentEvaluation> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      theRespon.add(evaluationFromMap(newMap));
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

  Future<List<StudentEvaluation>> selectStudentEvaluationByDateRange(
      String firstDate, String lastDate) async {
    final db = await initDb();
    final result = await db.query(
      EvaluationQuery.TABLE_NAME,
      where: "date >= ? and date <= ? ",
      whereArgs: [
        firstDate,
        lastDate,
      ],
      orderBy: 'id',
    );

    List<StudentEvaluation> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      theRespon.add(evaluationFromMap(newMap));
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

  StudentEvaluation evaluationFromMap(Map<String, Object?> newMap) {
    List<int> answers = [];
    for (int i = 0; i < 10; i++) {
      answers.add(newMap["pertanyaan$i"] as int);
    }
    newMap["answers"] = answers;
    var rowAbsen = StudentEvaluation.fromMap(newMap);
    return rowAbsen;
  }

//delete databases
  Future<int> delete(int id) async {
    final db = await initDb();
    int count = await db
        .delete(StudentQuery.TABLE_NAME, where: 'id=?', whereArgs: [id]);
    return count;
  }
}
