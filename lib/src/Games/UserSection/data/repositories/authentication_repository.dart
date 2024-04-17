import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/Games/UserSection/data/models/user_model.dart';
import 'package:mine_app/src/core/errors/failure.dart';
import 'package:mine_app/src/core/utils/db_utils.dart';
import 'package:mine_app/src/shared/repositories/db_repository.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

class AuthenticationRepository {
  Future<({Failure? error, bool? authenticated})> authenticate(UserModelRequest user) async {
    Database? dbUsers = await getIt<DBRepository>().database;

    try {
      String query = "SELECT * FROM ${DBUtils.usersTable} WHERE ${DBUtils.usernameColumn} = '${user.username}' AND ${DBUtils.passwordColumn} = '${user.password}'";
      List<Map<String, Object?>>? usersFound = await dbUsers?.rawQuery(
        query,
      );
      return (error: null, authenticated: usersFound != null && usersFound.isNotEmpty);
    } catch (e) {
      return (error: Failure(message: e.toString()), authenticated: null);
    }
  }

    Future<({Failure? error, bool? registered})> registerUser({required String username, required String password}) async {
    try {
      Database? dbMineApp = await getIt<DBRepository>().database;

      final List<Map<String, Object?>>? users = await dbMineApp?.rawQuery("SELECT * FROM ${DBUtils.usersTable} WHERE ${DBUtils.usernameColumn} = '$username'");
      if (users != null && users.isNotEmpty) {
        return (error: Failure(message: 'User already exists'), registered: null);
      }

      await dbMineApp?.insert(
        DBUtils.usersTable,
        UserModel(
          id: const Uuid().v4(),
          username: username,
          password: password,
          totalScore: 0,
        ).toJson(),
        
      );

      return (error: null, registered: true);
    } catch (error) {
      return (error: Failure(message: error.toString()), registered: null);
    }
  }
}
