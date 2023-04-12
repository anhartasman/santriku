import 'package:santriku/enums/enum_pertanyaan_evaluasi.dart';

class EvaluationQuery {
  static const String TABLE_NAME = "Evaluation";
  static String createTable() {
    String firstWords =
        "CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, studentId INTEGER, date TEXT,";
    PertanyaanEvaluasi.values.asMap().forEach((key, value) {
      firstWords += "pertanyaan${key} INTEGER";
      if (key + 1 < PertanyaanEvaluasi.values.length) {
        firstWords += ",";
      }
    });
    firstWords += ")";
    print("Evaluation CREATE query ${firstWords}");
    return firstWords;
  }

  static const String SELECT = "select * from $TABLE_NAME";
}
