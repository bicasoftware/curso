import 'package:curso/container/falta_container.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';

class StateProvas {
  List<NotasContainer> faltas;

  StateProvas(Periodos periodo) {
    faltas = List<NotasContainer>();
    _prepareFaltas(periodo.inicio, periodo.termino, periodo.materias);
  }

  List<Notas> _extractNotas(List<Materias> materias) {
    final notas = List<Notas>();
    materias.forEach((m) => notas.addAll(m.notas));
    notas.sort((a, b) => a.data.compareTo(b.data));
    return notas;
  }

  _prepareFaltas(DateTime inicio, DateTime termino, List<Materias> materias) {
    faltas.clear();
    final notas = _extractNotas(materias);
    final mesesComNotas = notas.map((n) => n.data.month).toSet();

    ///Adiciona somente meses que contém provas
    for (int mes in mesesComNotas) {
      final container = NotasContainer(mes: mes, dates: []);

      final Set<DateTime> datesInMonth =
          notas.where((n) => n.data.month == mes).map((n) => n.data).toSet();

      for (DateTime date in datesInMonth) {
        final notasByDate = NotasByDate(
          date: date,
          materias: [],
        );

        notas.where((nota) => nota.data == date).forEach((n) {
          final materia = materias.firstWhere((m) => m.id == n.idMateria);
          notasByDate.addMateria(
            MateriasByDate(
                id: materia.id,
                cor: materia.cor,
                nome: materia.nome,
                sigla: materia.sigla,
                notas: n),
          );
        });
        container.addDates(notasByDate);
      }
      faltas.add(container);
    }
  }
}
