import 'package:flutter/material.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final int? maxLines;

  UIText.dropdownLabel(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dropdownLabelStyle;
  UIText.dropdownHintRunning(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dropdownHintRunningStyle;
  UIText.dropdownHintLoss(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = dropdownHintLossStyle;
  UIText.textFieldLabelMinor(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = textFieldLabelMinorStyle;
  UIText.snackbarMessage(this.text, {super.key, this.textOverflow, this.maxLines, this.textAlign}) : style = snackbarMessageStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      overflow: textOverflow ?? TextOverflow.ellipsis,
      maxLines: maxLines ?? 4,
      textAlign: textAlign,
    );
  }
}
