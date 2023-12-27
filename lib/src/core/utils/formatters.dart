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
}