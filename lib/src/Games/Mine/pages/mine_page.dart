import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_menu_mine.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_card_mine.dart';

import 'package:mine_app/src/Games/Mine/pages/widgets/box_dropdown_vertical.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  late MineGameController _mineGameController;

  @override
  void initState() {
    super.initState();

    _mineGameController = getIt<MineGameController>();

    _mineGameController.addListener(() {
      if (mounted) setState(() {});
    });
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
            child: Text(
                'Score: ${getIt<UserController>().score.toStringAsFixed(2)}'), // Formatters.doubleToCurrency(0.0)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: UIPadding(
          useVerticalPadding: true,
          useHorizontalPadding: true,
          child: Column(
            children: [
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  itemCount: _mineGameController.isGameRunning || _mineGameController.isLoss ? _mineGameController.gameOptions.length : 25,
                  itemBuilder: (context, index) {
                    return _mineGameController.isGameRunning || _mineGameController.isLoss ? BoxCardMine(gameIcon: _mineGameController.gameOptions[index]) : const BoxCardMine();
                  },
              ),
              const SizedBox(height: 10),
              BoxMenuMine(
                startGame: () => _mineGameController.startGame(scoreToBet: 2),
                stopGame: _mineGameController.stopGame,
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  BoxDropdownVertical(
                    disabledHintText: 'Boa sorte!',
                    enabled: !_mineGameController.isGameRunning,
                    onChanged: (newBombsQuantity) {
                      _mineGameController.updateMinesQuantity(newBombsQuantity as int);
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
