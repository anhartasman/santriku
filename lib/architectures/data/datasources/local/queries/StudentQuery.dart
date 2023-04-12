class StudentQuery {
  static const String TABLE_NAME = "PesantrenMember";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, picture TEXT, birth TEXT, studentClass INTEGER, like TEXT, notlike TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
