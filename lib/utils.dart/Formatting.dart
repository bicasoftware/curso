import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class Formatting {
  static DateFormat _fmt = DateFormat("dd/MM/yyyy", "pt_BT");
  static DateFormat _defFmt = DateFormat("yyyy-MM-dd");
  static DateFormat _timeFormat = DateFormat("HH:mm");

  static DateTime get emptyDate => DateTime(1970, 1, 1);

  static DateTime get lastDate => DateTime(2030, 12, 31);

  static bool isCash(String value) {
    final regex = RegExp(r"""^\d+\,\d{2}$""");
    final matches = regex.allMatches(value);
    return matches.length == 1;
  }

  static bool isValidPercent(String value) {
    final isValid = RegExp(r"^\d+$").allMatches(value).length == 1;
    return isValid && int.parse(value) >= 30;
  }

  static MoneyMaskedTextController defaultMoneyMask(double initialValue) {
    return MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      initialValue: initialValue,
    );
  }

  static final f = NumberFormat("0.00", "pt_BR");

  static String doubleToCurrency(double value) => f.format(value);

  static double calcPorcentExtra(double salario, int cargaHoraria, int porc) {
    if (porc == 0) {
      return 0.0;
    } else {
      final rounded = ((salario / cargaHoraria) * (1 + (porc / 100))).toStringAsFixed(2);
      return double.parse(rounded);
    }
  }

  static String formatDate(DateTime date) {
    return _fmt.format(date);
  }

  static DateTime parseDate(String date) {
    return _defFmt.parse(date);
  }

  static String formatDbDate(DateTime date) {
    return _defFmt.format(date);
  }

  static String formatTime(DateTime time) {
    return _timeFormat.format(time);
  }

  static DateTime parseTime(String time) {
    return _timeFormat.parse(time);
  }

  static DateTime parseTimeOfDay(TimeOfDay t) {
    if (t == null) throw NullThrownError();
    return _timeFormat.parse("${t.hour}:${t.minute}");
  }
}
