import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/user_repository.dart';

class UserController extends ChangeNotifier {
  final ValueNotifier<double> score = ValueNotifier<double>(10.0);

  Future<bool> updateScore(double value) async {
    if (value.abs() > score.value) return false;

    score.value += value;
    // await getIt<UserRepository>().updateScore(, score.value);
    return true;
  }

  Future<String> registerUser({required String username, required String password}) async {
    String? errorMessage;

    final register = await getIt<UserRepository>().registerUser(username: username, password: password);
  
    register.fold((left) {
      errorMessage = left.message;
    }, (right) {
    });

    return errorMessage ?? '';
  }
}
