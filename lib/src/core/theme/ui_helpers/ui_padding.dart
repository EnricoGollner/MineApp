import 'package:flutter/material.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

///Cria um padding para o widget, seguindo a regra do aplicativo
class UIPadding extends StatelessWidget {
  final Widget? child;
  final bool useHorizontalPadding;
  final bool useVerticalPadding;

  const UIPadding({
    Key? key,
    required this.child,
    this.useHorizontalPadding = false, 
    this.useVerticalPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: useHorizontalPadding ? Theme.of(context).columnSize * 0.5 : 0,
        vertical: useVerticalPadding ? Theme.of(context).rowSize * 0.5 : 0,
      ),
      child: child,
    );
  }
}

///Cria um padding para o sliver, seguindo a regra do aplicativo
class UiPaddingSliver extends SliverPadding {
  final BuildContext context;

  @override
  UiPaddingSliver({
    Key? key,
    required Widget sliver,
    required bool useHorizontalPadding,
    required bool useVerticalPadding,
    required this.context,
  }) : super(
          key: key,
          sliver: sliver,
          padding: EdgeInsets.symmetric(
            vertical: useVerticalPadding ? Theme.of(context).rowSize * 0.5 : 0,
            horizontal: useHorizontalPadding ? Theme.of(context).columnSize * 0.5 : 0,
          ),
        );
}
