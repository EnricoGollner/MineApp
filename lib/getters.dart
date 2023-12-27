import 'package:get_it/get_it.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/authentication_repository.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/user_repository.dart';
import 'package:mine_app/src/base/repositories/db_repository.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton<DBRepository>(() => DBRepository());

  getIt.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository());
  
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<UserController>(() => UserController());

  getIt.registerLazySingleton<MineGameController>(() => MineGameController());
}