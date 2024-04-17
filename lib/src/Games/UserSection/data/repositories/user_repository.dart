import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/user_model.dart';
import 'package:mine_app/src/core/utils/db_utils.dart';
import 'package:mine_app/src/core/utils/local_storage_keys.dart';
import 'package:mine_app/src/shared/repositories/db_repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
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


  Future<List<UserModel>> getAllUsers() async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    List<Map<String, dynamic>>? jsonList = await dbMineApp?.rawQuery("SELECT * FROM ${DBUtils.usersTable}");

    if (jsonList != null) {
      List<UserModel> listItemsToShop =
          jsonList.map((e) => UserModel.fromJson(e)).toList();
      return listItemsToShop;
    }

    return [];
  }

  Future<UserModel?> getOneUser(String id) async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    List<Map<String, dynamic>>? maps = await dbMineApp?.query(
      DBUtils.usersTable,
      columns: [
        DBUtils.idColumn,
        DBUtils.usernameColumn,
        DBUtils.passwordColumn,
        DBUtils.totalScoreColumn,
      ],
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [id],
    );

    if (maps != null && maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }

    return null;
  }

  Future<int?> deleteById(String userId) async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    return await dbMineApp?.delete(
      DBUtils.usersTable,
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [userId],
    );
  }

  Future<int?> updateUser(UserModel item) async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    return await dbMineApp?.update(
      DBUtils.usersTable,
      item.toJson(),
      where: "${DBUtils.idColumn} = ?",
      whereArgs: [item.id],
    );
  }

  Future<void> updateScore(String id, double newScore) async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    await dbMineApp?.rawUpdate("UPDATE ${DBUtils.usersTable} SET ${DBUtils.totalScoreColumn} = $newScore WHERE ${DBUtils.idColumn} = '$id'");
  }

  Future<void> close() async {
    Database? dbUsers = await getIt<DBRepository>().database;
    dbUsers?.close();
  }
}
