import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_snack_bar.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';

class MineGameController extends ChangeNotifier {
  List<int> _indexesMines = [];
  // List<int> get indexesMines => _indexesMines;

  List<IconData> gameOptions = []; // Positions of the game (including mines) to build the cards

  bool _isGameRunning = false;
  bool get isGameRunning => _isGameRunning;

  int _minesQuantity = 2;
  int get minesQuantity => _minesQuantity;

  bool _loss = false;
  bool get isLoss => _loss;

  double _scoreBet = 0.0;
  double get scoreBet => _scoreBet;

  void startGame({required double scoreToBet}) {
    _loss = false;
    _scoreBet = scoreToBet;

    //TODO - Retirar do valor de score do usuário o valor/score da aposta

    _indexesMines = generateMinesPositions(range: 25, minesQuantity: _minesQuantity);
    debugPrint('$_indexesMines');

    gameOptions = List.generate(25, (index) {
      if (_indexesMines.contains(index)) {
        return MdiIcons.bomb;
      }

      return Icons.diamond;
    });

    _isGameRunning = true;
    notifyListeners();
  }

  void stopLostGame(BuildContext context) {
    _loss = true;
    showSnackBar(context, const BoxSnackBar.error(message: 'Não foi dessa vez!'));

    stopGame();
  }

  void stopGame() {
    _isGameRunning = false;
    
    if(!_loss) getIt<UserController>().addScore(_scoreBet);
    debugPrint('Score: $_scoreBet');

    _scoreBet = 0.0;
    notifyListeners();
  }

  ///Método para adicionar score
  void addScore() {
    final double percenatageGained = (0.1 * _minesQuantity);
    _scoreBet += percenatageGained;
  }

  void updateMinesQuantity(int newValue) {
    _minesQuantity = newValue;
    notifyListeners();
  }

  List<int> generateMinesPositions({required int range, required int minesQuantity}) {
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
