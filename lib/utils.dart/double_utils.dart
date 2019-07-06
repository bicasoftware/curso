import 'package:intl/intl.dart';

double parseDoubleFromText(String value) {
  final replacedVal = value.replaceAll(",", ".");
  return double.tryParse(replacedVal);
}

String formatNota(double nota) {
  return NumberFormat("#0.##").format(nota ?? 0.0).padRight(5, " ");
}

double calcPorcentagemAulas(int totalAulas, int totalFaltas) {
  return (totalFaltas / totalAulas) * 100;
}

double calcMedia(List<double> notas) {
  double somaNotas;
  if (notas.length > 0) {
    somaNotas = 0.0;
    notas.forEach((double n) => somaNotas += n);
  }

  if (somaNotas == null || notas.length == 0) {
    return null;
  } else {
    return somaNotas / notas.length;
  }
}