import 'dart:io';

import 'package:intl/intl.dart';

class Formatters {
   ///Método para formatar um valor double para o fomato de moeda 'Real Brasileiro - R$'
  static String doubleToCurrency(double value, {bool isAsFixedZero = false}) {
    String symbol = 'R\$ ';

    if (isAsFixedZero) {
      if (value == 0) {
        return '0,00';
      } else {
        final currentFormatter = NumberFormat.simpleCurrency(locale: 'pt_Br');
        return symbol + currentFormatter.format(value);
      }
    } else {
      return NumberFormat.currency(symbol: symbol, locale: Platform.localeName).format(value);
    }
  }

  static num defaultTextEditingControllerFormatter({required String text, bool isDecimal = true}) {
    if (text.isEmpty) {
      if (isDecimal) {
        return 0.0;
      } else {
        return 0;
      }
    } else {
      text = text.replaceAll('R\$ ', '');
      if (isDecimal) {
        if (Platform.localeName == 'pt_BR') {
          text = text.replaceAll('.', '');
          text = text.replaceAll(',', '.');
        } else if (Platform.localeName == 'en_US') {
          text = text.replaceAll(',', '');
        }
        return double.parse(text);
      } else {
        return int.parse(text);
      }
    }
  }
}