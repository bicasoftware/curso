import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class StateMain {
  List<Periodos> periodos;
  int _currentId, mes;
  DateTime selectedDate;

  StateMain({
    @required this.periodos,
  }) {
    this._currentId = periodos.first.id;
    _positionDates();
  }

  _positionDates() {
    final meses = range(currentPeriodo.inicio.month, currentPeriodo.termino.month);
    ///final meses = range(periodos[_currentId].inicio.month, periodos[_currentId].termino.month);
    if (!meses.contains(DateTime.now().month)) {
      mes = currentPeriodo.inicio.month;
      selectedDate = currentPeriodo.inicio;
    } else {
      mes = DateTime.now().month;
      selectedDate = DateTime.now();
    }
  }

  Periodos get currentPeriodo => periodos.firstWhere((it) => it.id == _currentId);

  setCurrentPeriodoId(int idPeriodo) {
    _currentId = idPeriodo;

    ///se hoje estiver entre o início e o término do período, seta a data selecionada como hoje
    ///senão, coloca a data selecionada como a primeira data do calendário
    final now = DateTime.now();
    if (now.isAfter(currentPeriodo.inicio) && now.isBefore(currentPeriodo.termino)) {
      selectedDate = now;
      mes = selectedDate.month;
    } else {
      selectedDate = currentCalendario.dates.first.date;
      mes = currentCalendario.mes;
    }
  }

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
