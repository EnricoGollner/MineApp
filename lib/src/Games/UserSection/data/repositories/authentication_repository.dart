import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/base/repositories/db_repository.dart';
import 'package:mine_app/src/base/utils/db_utils.dart';
import 'package:sqflite/sqlite_api.dart';

class AuthenticationRepository {
  Future<bool> authenticate(UserModelRequest user) async {
    Database? dbUsers = await getIt<DBRepository>().database;

    List<Map<String, Object?>>? usersFound = await dbUsers?.rawQuery(
      "SELECT * FROM ${DBUtils.usersTable} WHERE ${DBUtils.usernameColumn} = ${user.username} AND ${DBUtils.passwordColumn} = ${user.password}"
    );

    return usersFound?.isEmpty ?? false;
  }
}
