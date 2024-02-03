class DBUtils {
  static const String userTable = "itemsTable";

  static const String idUser = "idColumn";
  static const String user = "user";
  static const String value = "value";

  static const String createTableQuery =
      "CREATE TABLE ${DBUtils.userTable}("
      "${DBUtils.idUser} VARCHAR(50) PRIMARY KEY,"
      "${DBUtils.user} VARCHAR(100),"
      "${DBUtils.value} DOUBLE"
      ")";
}
