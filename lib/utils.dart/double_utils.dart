import 'package:intl/intl.dart';

double parseDoubleFromText(String value) {
  final replacedVal = value.replaceAll(",", ".");
  return double.tryParse(replacedVal);
}

String formatNota(double nota) {
  return NumberFormat("#0.##").format(nota ?? 0.0).padRight(5, " ");
}
