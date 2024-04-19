import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mine_app/src/core/utils/formatters.dart';

class Validators {
  final String text;

  Validators({required this.text});

  static String? betIsRequired(String? text) {
    if(text == null || text.isEmpty) {
      return 'O valor da aposta é obrigatório';
    }

    return null;
  }
  ///Método que verifica se um determinado valor é maior que um valor mínimo
  static String? greaterThanMinValueRequired(String? value, {num minValue = 0, required String nomeCampo, FocusNode? focusNode}) {
    String? mensagem = Validators.betIsRequired(value);
    if (mensagem != null) {
      focusNode?.requestFocus();
      return mensagem;
    }

    final num numValue = Formatters.defaultTextEditingControllerFormatter(text: value!);
    if (numValue <= minValue) {
    focusNode?.requestFocus();
    return '$nomeCampo deve ser igual ou maior que $minValue';
  }

    return null;
  }

  /// Método para validar se o número está terminando com as casas decimais de forma correta
  static void handleDecimal(TextEditingController controller, {int decimalRange = 2}){
      String signal = Platform.localeName == 'pt_BR' ? ',' : '.';
      String value = controller.text;
      if(value.isNotEmpty){
        if (!value.contains(signal)) {
          value += signal;
        }

        List<String> parts = value.split(signal);
        String decimalPart = parts.length > 1 ? parts[1] : '';
        int currentDecimalRange = decimalPart.length;

        if (currentDecimalRange < decimalRange) {
          int zerosToAdd = decimalRange - currentDecimalRange;
          String zeros = '0' * zerosToAdd;

          controller.value = controller.value.copyWith(
            text: '$value$zeros',
            selection: TextSelection.collapsed(offset: '$value$zeros'.length),
          );
        }
      }
    }
}