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
  late AnimationController _animationController;
  late MineGameController _mineGameController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _mineGameController = getIt<MineGameController>();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void flipCard() {
    if (widget.gameIcon != null) {
      _animationController.forward();

      widget.gameIcon == MdiIcons.bomb
        ? _mineGameController.stopLostGame(context)
        : _mineGameController.addScore();
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
    if (_mineGameController.gameIsRunning) {
      _animationController.reset();
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final angulo = _animationController.value * pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(angulo);

        return GestureDetector(
          onTap: () => getIt<MineGameController>().gameIsLost ? null : flipCard(),
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
