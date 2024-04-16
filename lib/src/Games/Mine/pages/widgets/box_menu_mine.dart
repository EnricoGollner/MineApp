import 'package:flutter/material.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/core/utils/decimal_text_input_formatter.dart';
import 'package:mine_app/src/shared/widgets/box_text_field.dart';
import 'package:mine_app/src/core/utils/formatters.dart';
import 'package:mine_app/src/core/utils/validators.dart';
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
            validatorFunction: Validators.isRequired,
            keyboardType: TextInputType.number,
            onEditingComplete: () => Validators.handleDecimal(_newBetController),
            onTapOutside: (event) => Validators.handleDecimal(_newBetController),
            inputFormatters: [
              DecimalInputFormatter.signalBasedOnLocale,
              DecimalInputFormatter(decimalRange: 2, isCurrency: true),
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
