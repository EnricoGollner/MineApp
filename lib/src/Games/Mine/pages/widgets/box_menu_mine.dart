import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/base/widgets/box_text_field.dart';
import 'package:mine_app/src/core/utils/formatters.dart';
import 'package:mine_app/src/core/utils/validator.dart';
import 'package:sizer/sizer.dart';

class BoxMenuMine extends StatelessWidget {
  final void Function() startGame;
  final void Function() stopGame;

  BoxMenuMine({super.key, required this.startGame, required this.stopGame});

  final TextEditingController _newBetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50.w,
          child: BoxTextField(
            height: 50,
            controller: _newBetController,
            hintText: Formatters.doubleToCurrency(0.0),
            validatorFunction: Validator.isRequired,
            keyboardType: TextInputType.number,
            
            inputFormatters: [
              // DecimalInputFormatter.signalBasedOnLocale,
              // DecimalInputFormatter(decimalRange: 2),
              CurrencyTextInputFormatter()
            ],
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: getIt<MineGameController>().isGameRunning ? stopGame : startGame,
          child: getIt<MineGameController>().isGameRunning && !getIt<MineGameController>().isLoss ? const Text("PARAR") : const Text("COMEÇAR"),
        ),
      ],
    );
  }
}
