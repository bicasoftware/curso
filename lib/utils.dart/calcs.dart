import 'package:curso/models/aulas.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meta/meta.dart';

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

int countWeekDayInRange(DateTime inicio, DateTime termino, int dayToCount) {
  initializeDateFormatting("pt_BR", null);
  if (inicio.isAfter(termino)) {
    throw Exception(Errors.datasInvalidas);
  }
  int count = 0;
  DateTime currentDay = inicio;
  while (currentDay.isBefore(termino)) {
    if (getWeekday(currentDay) == dayToCount) {
      count += 1;
    }
    currentDay = currentDay.add(const Duration(days: 1));
  }
  if (getWeekday(currentDay) == dayToCount) {
    count += 1;
  }

  return count;
}

bool faltasEmDia(int presObrig, int totalAulas, int totalFaltas) {
  final double porcentagem = calcPorcentagemAulas(totalAulas, totalFaltas);
  return porcentagem != null && porcentagem < presObrig;
}

List<int> countAulasInRange(DateTime inicio, DateTime termino) {
  return List.generate(7, (int i) => countWeekDayInRange(inicio, termino, i));
}

int countTotalAulasSemestre(Materias m, List<int> aulasSemestre) {
  final Set<int> diasComAula = m.aulas.map((m) => m.weekDay).toSet();

  final t = calcNumAulasSemestre(
    aulas: m.aulas,
    diasComAula: diasComAula,
    weekDaysInRange: aulasSemestre,
    idMateria: m.id,
  );

  return t;
}

int totalAulasRestantes({
  @required DateTime inicio,
  @required DateTime termino,
  @required Materias m,
}) {
  return countTotalAulasSemestre(m, countAulasInRange(inicio, DateTime.now()));
}
