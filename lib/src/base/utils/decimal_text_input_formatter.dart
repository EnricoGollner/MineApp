
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  DecimalInputFormatter({this.decimalRange = 2});

  final int decimalRange;

  static FilteringTextInputFormatter get signalBasedOnLocale => Platform.localeName == 'pt_BR'
    ? FilteringTextInputFormatter.allow(RegExp("[0-9,]"))
    : FilteringTextInputFormatter.allow(RegExp("[0-9.]"));

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;
    String signal = Platform.localeName == 'pt_BR' ? ',' : '.';

    String value = newValue.text;

    if(!value.contains(signal) && value.length > 4) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } 

    if (value.contains(signal) && value.substring(value.indexOf(signal) + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == signal) {
      truncated = "0$signal";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );

    } else if (value.contains(signal)) {
      String tempValue = value.substring(value.indexOf(signal) + 1);
      
      if (tempValue.contains(signal)) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }

      if (value.indexOf(signal) == 0) {
        truncated =  '0$truncated';
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length),
          extentOffset: math.min(truncated.length, truncated.length),
        );
      }
    }

    if (value.contains(" ") || value.contains("-")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length),
        extentOffset: math.min(truncated.length, truncated.length),
      ),
      composing: TextRange.empty,
    );
  }

}