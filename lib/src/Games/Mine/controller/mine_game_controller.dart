import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/pages/state/game_state.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_snack_bar.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';

class MineGameController extends ChangeNotifier {
  final UserController _userController = getIt<UserController>();

  List<int> _indexesMines = []; // Positions of the mines
  List<IconData> gameOptions = []; // Positions of the game (including mines) to build the cards

  GameState _gameState = GameState.initial;
  bool get gameIsRunning => _gameState == GameState.running;
  bool get gameIsLost => _gameState == GameState.lost;
  bool get gameIsWon => _gameState == GameState.won;

  final ValueNotifier<double> gains = ValueNotifier<double>(0.0);

  void _changeGameState({required GameState newState}) {
    _gameState = newState;
    notifyListeners();
  }

  int _minesQuantity = 2;
  int get minesQuantity => _minesQuantity;

  double _scoreBet = 0.0;
  double get scoreBet => _scoreBet;

  Future<void> startGame(BuildContext context, {required double scoreToBet}) async {
    _changeGameState(newState: GameState.running);

    await _userController.updateScore(-scoreToBet).then((transactionAccepted) {
      if (!transactionAccepted) {
        stopGame(newState: GameState.initial);
        showSnackBar(context, const BoxSnackBar.error(message: 'Saldo insuficiente!'));
      }
    });

    _indexesMines = _generateMinesPositions(range: 25, minesQuantity: _minesQuantity);
    debugPrint('${_indexesMines..sort()}');

    gameOptions = List.generate(25, (index) {
      if (_indexesMines.contains(index)) {
        return MdiIcons.bomb;
      }

      return Icons.diamond;
    });
    
    notifyListeners();
  }

  void stopLostGame(BuildContext context) {
    _changeGameState(newState: GameState.lost);
    showSnackBar(context, const BoxSnackBar.error(message: 'Não foi dessa vez!'));

    stopGame(newState: GameState.lost);
  }

  void stopGame({GameState newState = GameState.won}) {
    _changeGameState(newState: newState);
    if(_gameState == GameState.won) getIt<UserController>().updateScore(_scoreBet + gains.value);
    gains.value = 0.0;
    _scoreBet = 0.0;
    notifyListeners();
  }

  ///Método para adicionar score
  void addScore() {
    gains.value += (0.05 * _minesQuantity);
  }

  void updateMinesQuantity(int newValue) {
    _minesQuantity = newValue;
    notifyListeners();
  }

  List<int> _generateMinesPositions({required int range, required int minesQuantity}) {
    List<int> newIndexesMines = [];

    while (newIndexesMines.length < minesQuantity) {
      int newBombIndex = Random().nextInt(range);

      if (!newIndexesMines.contains(newBombIndex)) {
        newIndexesMines.add(newBombIndex);
      }
    }

    return newIndexesMines;
  }
}
