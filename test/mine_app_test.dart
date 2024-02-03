import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:test/test.dart';

void main() {
  final MineGameController mineGameController = MineGameController();
  
  test('Teste para verificar se os números gerados estão repetindo', () {
    final List<int> generatedIndexes = mineGameController.generateMinesPositions(range: 25, minesQuantity: 25);
    final List<int> noRepeatIndexes = generatedIndexes.toSet().toList();

    generatedIndexes.sort();
    noRepeatIndexes.sort();
    debugPrint(generatedIndexes.toString());
    debugPrint(noRepeatIndexes.toString());

    expect(generatedIndexes, equals(noRepeatIndexes));
  });
}