class DBUtils {
  static const String usersTable = 'usersTable';

  static const String idColumn = 'idColumn';
  static const String usernameColumn = 'usernameColumn';
  static const String passwordColumn = 'passwordColumn';
  static const String totalScoreColumn = 'totalScore';

  static const String createTableUsersQuery =
      "CREATE TABLE ${DBUtils.usersTable}("
      "${DBUtils.idColumn} VARCHAR(50) PRIMARY KEY,"
      "${DBUtils.usernameColumn} VARCHAR(20),"
      "${DBUtils.passwordColumn} VARCHAR(40),"
      "${DBUtils.totalScoreColumn} DOUBLE)";
}
