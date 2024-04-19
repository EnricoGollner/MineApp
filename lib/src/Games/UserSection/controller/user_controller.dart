import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserController extends ChangeNotifier {
  final ValueNotifier<double> score = ValueNotifier<double>(300.0);

  Future<bool> updateScore(double value, {required Operation operation}) async {
    if (operation == Operation.remove) {
      if (score.value < value) return false;
      score.value -= value;
    } else {
      score.value += value;
    }
    // await getIt<UserRepository>().updateScore(, score.value);
    return true;
  }
}

enum Operation {
  remove,
  add
}
