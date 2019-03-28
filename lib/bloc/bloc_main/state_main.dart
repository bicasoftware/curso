import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class StateMain {
  List<Periodos> periodos;
  int periodoPos, mes;
  DateTime selectedDate;

  StateMain({
    @required this.periodos,
    @required this.periodoPos,
  }) {
    if (this.periodoPos == null) this.periodoPos = 0;
    _positionDates();
  }

  _positionDates() {
    final meses = range(periodos[periodoPos].inicio.month, periodos[periodoPos].termino.month);
    if (!meses.contains(DateTime.now().month)) {
      mes = periodos[periodoPos].inicio.month;
      selectedDate = periodos[periodoPos].inicio;
    } else {
      mes = DateTime.now().month;
      selectedDate = DateTime.now();
    }
  }

  setPeriodoPos(int periodoPos) => periodoPos = periodoPos;

  Periodos get currentPeriodo => periodos[periodoPos];

  setMes(int mes) => this.mes = mes;

  incMes() {
    if (mes < currentPeriodo.termino.month) {
      this.mes++;
      selectedDate = currentCalendario.dates.first.date;
    }
  }

  decMes() {
    if (mes > currentPeriodo.inicio.month) {
      this.mes--;
      selectedDate = currentCalendario.dates.first.date;
    }
  }

  ///Data selecionada via CalendarioCellStrip
  setSelectedDate(DateTime newDate) => selectedDate = newDate;

  DataDTO get aulasDia {
    return currentCalendario.dates.firstWhere((d) => isSameDay(d.date, selectedDate));
  }

  CalendarioDTO get currentCalendario => currentPeriodo.getCalendarioByMonth(mes);

  removePeriodoById(int idPeriodo) {
    periodos.remove(periodos.firstWhere((it) => it.id == idPeriodo));
  }

  addPeriodo(Periodos p) {
    periodos.add(p);
  }

  updatePeriodo(Periodos p) {
    int index = periodos.indexWhere((it) => it.id == p.id);
    periodos[index] = p..refreshCalendario();
  }

  _refreshCalendario(int idPeriodo) {
    periodos.firstWhere((it) => it.id == idPeriodo).refreshCalendario();
  }

  refreshMaterias(int idPeriodo, List<Materias> materias) {
    periodos.firstWhere((it) => it.id == idPeriodo).materias = materias;

    _refreshCalendario(idPeriodo);
  }

  insertAula(int idPeriodo, int idMateria, Aulas aula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .firstWhere((it) => it.id == idMateria)
        .aulas
        .add(aula);

    _refreshCalendario(idPeriodo);
  }

  deleteAula(int idPeriodo, int idAula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .forEach((m) => m.aulas.removeWhere((it) => it.id == idAula));

    _refreshCalendario(idPeriodo);
  }
}
