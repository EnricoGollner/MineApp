import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_menu_mine.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_card_mine.dart';

import 'package:mine_app/src/Games/Mine/pages/widgets/box_dropdown_vertical.dart';
import 'package:mine_app/src/core/utils/formatters.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late MineGameController _mineGameController;
  final TextEditingController _newBetTxtController = TextEditingController();

  @override
  void initState() {
    _mineGameController = getIt<MineGameController>();
    super.initState();
  }

  @override
  void dispose() {
    _mineGameController.dispose();
    _newBetTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.diamond),
        title: const Text('Mine Game'),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorSecondary),
            ),
            child: ValueListenableBuilder(
              valueListenable: getIt<UserController>().score,
              builder: (context, score, child) => Text('Score: ${Formatters.doubleToCurrency(score)}')),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: UIPadding(
          useVerticalPadding: true,
          useHorizontalPadding: true,
          child: ListenableBuilder(
            listenable: _mineGameController,
            builder: (context, child) => Column(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  itemCount: _mineGameController.gameIsRunning ? _mineGameController.gameOptions.length : 25,
                  itemBuilder: (context, index) {
                    return _mineGameController.gameIsRunning || _mineGameController.gameIsLost ? BoxCardMine(gameIcon: _mineGameController.gameOptions[index]) : const BoxCardMine();
                  },
                ),
                const SizedBox(height: 10),
                BoxMenuMine(
                  betTextController: _newBetTxtController,
                  gameIsRunning: _mineGameController.gameIsRunning,
                  startGame: () => _mineGameController.startGame(context, scoreToBet: Formatters.defaultTextEditingControllerFormatter(text: _newBetTxtController.text).toDouble()),
                  stopGame: _mineGameController.stopGame,
                ),
                const SizedBox(height: 10),
                BoxDropdown<int>(
                  disabledHintText: 'Boa sorte!',
                  enabled: !_mineGameController.gameIsRunning,
                  onChanged: (newBombsQuantity) {
                    _mineGameController.updateMinesQuantity(newBombsQuantity);
                  },
                  initialValue: _mineGameController.minesQuantity,
                  label: 'NÚMERO DE MINAS',
                  items: List.generate(12, (index) => (index + 1) * 2)
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text('$e'),
                        ),
                      )
                      .toList(),
                  isWhite: false,
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }
}
