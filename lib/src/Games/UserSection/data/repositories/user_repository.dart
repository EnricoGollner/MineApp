import 'package:dartz/dartz.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/user_model.dart';
import 'package:mine_app/src/core/utils/db_utils.dart';
import 'package:mine_app/src/shared/repositories/db_repository.dart';
import 'package:mine_app/src/core/errors/failure.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  Future<Either<Failure, bool>> registerUser(
      {required String username, required String password}) async {
    try {
      Database? dbItemsShop = await getIt<DBRepository>().database;

      await dbItemsShop?.insert(
        DBUtils.usersTable,
        UserModel(
          id: const Uuid().v4(),
          username: username,
          password: password,
          scores: 0,
        ).toJson(),
      );

      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    Database? dbMineApp = await getIt<DBRepository>().database;

    List<Map<String, dynamic>>? jsonList =
        await dbMineApp?.rawQuery("SELECT * FROM ${DBUtils.usersTable}");

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

    await dbMineApp?.rawUpdate(
        "UPDATE ${DBUtils.usersTable} SET ${DBUtils.totalScoreColumn} = $newScore WHERE ${DBUtils.idColumn} = '$id'");
  }

  Future<void> close() async {
    Database? dbUsers = await getIt<DBRepository>().database;
    dbUsers?.close();
  }
}
