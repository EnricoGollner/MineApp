import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_snack_bar.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/core/utils/decimal_text_input_formatter.dart';
import 'package:mine_app/src/shared/widgets/box_text_field.dart';
import 'package:mine_app/src/core/utils/formatters.dart';
import 'package:mine_app/src/core/utils/validators.dart';

class BoxMenuMine extends StatelessWidget {
  final bool gameIsRunning;
  final void Function() startGame;
  final void Function() stopGame;
  final TextEditingController betTextController;

  BoxMenuMine({
    super.key,
    required this.gameIsRunning,
    required this.startGame,
    required this.stopGame,
    required this.betTextController,
  });

  final FocusNode _betFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BoxTextField(
            enabled: !gameIsRunning,
            isOntapClear: true,
            controller: betTextController,
            hintText: Formatters.doubleToCurrency(0.0),
            keyboardType: TextInputType.number,
            onEditingComplete: () => Validators.handleDecimal(betTextController),
            onTapOutside: (event) => Validators.handleDecimal(betTextController),
            inputFormatters: [
              DecimalInputFormatter.signalBasedOnLocale,
              DecimalInputFormatter(isCurrency: true),
            ],
          ),
        ),
        SizedBox(width: 10.s),
        ValueListenableBuilder(
          valueListenable: getIt<MineGameController>().gains,
          builder: (_, gainsNumber, __) {
            return SizedBox(
              height: 54.s,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: gameIsRunning && gainsNumber == 0 ? null : () {
                  final String? error = Validators.greaterThanMinValueRequired(betTextController.text, nomeCampo: 'Valor da aposta', minValue: 0.1, focusNode: _betFocusNode);
    
                  if (error != null) {
                    showSnackBar(context, BoxSnackBar.error(message: error));
                    return;
                  }
                  
                  gameIsRunning ? _stopGame() : startGame();
                },
                child: gameIsRunning
                    ? const Text("PARAR")
                    : const Text("COMEÇAR"),
              ),
            );
          },
        ),
      ],
    );
  }

  void _stopGame() {
    betTextController.text = Formatters.doubleToCurrency(0.0);
    stopGame();
  }
}
