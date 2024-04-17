import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserController extends ChangeNotifier {
  final ValueNotifier<double> score = ValueNotifier<double>(10.0);

  Future<bool> updateScore(double value) async {
    if (value.abs() > score.value) return false;

    score.value += value;
    // await getIt<UserRepository>().updateScore(, score.value);
    return true;
  }
}
