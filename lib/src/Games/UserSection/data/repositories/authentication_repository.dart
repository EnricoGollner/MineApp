import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/Games/UserSection/data/models/user_model.dart';
import 'package:mine_app/src/core/utils/db_utils.dart';
import 'package:mine_app/src/core/utils/local_storage_keys.dart';
import 'package:mine_app/src/shared/repositories/db_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class AuthenticationRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();


  Future<bool> authenticate(UserModelRequest user) async {
    Database? dbUsers = await getIt<DBRepository>().database;

    try {
      List<Map<String, Object?>>? usersFound = await dbUsers?.rawQuery(
        "SELECT * FROM ${DBUtils.usersTable} WHERE ${DBUtils.usernameColumn} = ${user.username} AND ${DBUtils.passwordColumn} = ${user.password}"
      );

      return usersFound?.isEmpty ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveUserAuthentication(UserModel userModelRequest) {
    return getIt<DBRepository>().database.then((db) async {
      await _secureStorage.write(key: LocalStorageKeys.user, value: userModelRequest.username);
      await _secureStorage.write(key: LocalStorageKeys.password, value: userModelRequest.password);
    });
  }

  Future<UserModel> getUserAuthentication() async {
    String? username = await _secureStorage.read(key: LocalStorageKeys.user);
    String? password = await  _secureStorage.read(key: LocalStorageKeys.password);

    return UserModel(username: username ?? '', password: password ?? '');
  }

  Future<void> deleteUserAuthentication() async {
    await _secureStorage.delete(key: LocalStorageKeys.user);
    await _secureStorage.delete(key: LocalStorageKeys.password);
  }
}
