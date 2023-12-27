

import 'package:mine_app/src/base/utils/db_utils.dart';
import 'package:sqflite/sqflite.dart';

class DBRepository {
  // factory DBRepository() => _instance;
  // static final _instance = DBRepository.internal(); // Singleton
  // DBRepository.internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDB();
    return _database;
  }

  ///Método para inicializar o banco de dados SQLite
  Future<Database?> _initDB() async {
    final String databasePath = await getDatabasesPath();
    final String path = "$databasePath/games.db";

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(DBUtils.createTableUsersQuery);
    },);
  }

  Future<void> close() async {
    Database? dbItemsToshop = await database;
    dbItemsToshop?.close();
  }
}
