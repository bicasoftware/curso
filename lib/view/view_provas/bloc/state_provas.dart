import 'package:curso/container/falta_container.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/date_utils.dart';

class StateProvas {
  List<NotasContainer> provas;

  StateProvas(Periodos periodo) {
    provas = List<NotasContainer>();
    _prepareFaltas(periodo.inicio, periodo.termino, periodo.materias);
  }

  List<Notas> _extractNotas(List<Materias> materias) {
    final notas = List<Notas>();
    materias.forEach((m) => notas.addAll(m.notas));
    notas.sort((a, b) => a.data.compareTo(b.data));
    return notas;
  }

  _prepareFaltas(DateTime inicio, DateTime termino, List<Materias> materias) {
    provas.clear();
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
      provas.add(container);
    }
  }

  void updateProva(Notas nota) {
    provas
        .firstWhere((p) => p.mes == nota.data.month)
        .dates
        .firstWhere((d) => isSameDay(d.date, nota.data))
        .materias
        .firstWhere((m) => m.id == nota.idMateria)
        .notas = nota;
  }
}
