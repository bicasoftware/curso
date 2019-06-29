import 'package:curso/container/aulas.dart';
import 'package:curso/container/notas.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

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

bool statusFaltas(int presObrig, int totalAulas, int totalFaltas) {
  final double porcentagem = calcPorcentagemAulas(totalAulas, totalFaltas);
  return porcentagem != null && porcentagem < presObrig;
}

double calcMedia(List<Notas> notas) {
  double somaNotas;
  final notasValidas = notas.where((n) => n.nota != null).map((n) => n.nota);

  if (notasValidas.length > 0) {
    somaNotas = 0.0;
    notasValidas.forEach((double n) => somaNotas += n);
  }

  if (somaNotas == null || notas.length == 0) {
    return null;
  } else {
    return somaNotas / notas.length;
  }
}

int calcNumAulasSemestre({
  @required Set<int> diasComAula,
  @required List<int> weekDaysInRange,
  @required List<Aulas> aulas,
  @required int idMateria,
}) {
  int totalAulasSemana = 0;
  int totalAulasSemestre = 0;

  for (final diaComAula in diasComAula) {
    ///Incrementa total de aulas do semestre
    totalAulasSemestre += weekDaysInRange[diaComAula];

    ///Incrementa total de aulas da semana
    totalAulasSemana +=
        aulas.where((aula) => aula.weekDay == diaComAula && aula.idMateria == idMateria).length;
  }

  ///80 sextas-feiras, com 4 aulas, somam 320 aulas, que são o total de aulas do semestre
  return totalAulasSemestre * totalAulasSemana;
}
