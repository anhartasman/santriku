class MemberQuery {
  static const String TABLE_NAME = "FamilyMember";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, picture TEXT, birth TEXT, childRank INTEGER, like TEXT, notlike TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
