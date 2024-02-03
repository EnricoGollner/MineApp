import 'dart:math';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mine_app/src/Games/Mine/controller/mine_game_controller.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BoxCardMine extends StatefulWidget {
  final IconData? gameIcon;

  const BoxCardMine({super.key, this.gameIcon});

  @override
  State<BoxCardMine> createState() => _BoxCardMineState();
}

class _BoxCardMineState extends State<BoxCardMine> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void flipCard() {
    if (widget.gameIcon != null) {
      animationController.forward();

      if (widget.gameIcon == MdiIcons.bomb) {
        getIt<MineGameController>().stopLostGame(context);
      } else {
        getIt<MineGameController>().addScore();
      }
    }
  }

  Icon? _getCardContent(double angulo) {
    if (angulo > 0.55 * pi) {
      return Icon(
        widget.gameIcon,
        color: widget.gameIcon == MdiIcons.bomb ? colorError : colorSecondary,
        size: 30,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (getIt<MineGameController>().isGameRunning) {
      animationController.reset();
    }

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        final angulo = animationController.value * pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(angulo);

        return GestureDetector(
          onTap: () => getIt<MineGameController>().isLoss ? null : flipCard(),
          child: Transform(
            transform: transform,
            alignment: Alignment.center,
            child: Card(
              elevation: 7.0,
              color: colorMineCard,
              margin: const EdgeInsets.all(4),
              child: _getCardContent(angulo),
            ),
          ),
        );
      },
    );
  }
}
