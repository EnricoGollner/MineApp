import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/user_repository.dart';

class UserController extends ChangeNotifier {
  double _score = 0.0;
  double get score => _score;

  Future<void> addScore(double value) async {
    _score += value;
    // await getIt<UserRepository>().updateScore(, score);
    notifyListeners();
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
