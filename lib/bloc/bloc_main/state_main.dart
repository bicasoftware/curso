import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/container/periodos_posicao.dart';
import 'package:curso/container/provas_notas_materias.dart';
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

    if (!meses.contains(DateTime.now().month)) {
      mes = currentPeriodo.inicio.month;
      selectedDate = currentPeriodo.inicio;
    } else {
      mes = DateTime.now().month;
      selectedDate = DateTime.now();
    }
  }

  Periodos get currentPeriodo => periodos.firstWhere((it) => it.id == _currentId);

  double get calendarStripPosition {
    return _containsDate(currentCalendario.dates) ? (selectedDate.day - 1) * 70.0 : 0.0;
  }

  bool _containsDate(List<DataDTO> datas) {
    final n = DateTime.now();
    final count = datas.firstWhere(
      (d) => isSameDay(d.date, n),
      orElse: () => null,
    );

    return count != null;
  }

  setCurrentPeriodoId(int idPeriodo) {
    _currentId = idPeriodo;

    ///se hoje estiver entre o início e o término do período, seta a data selecionada como hoje
    ///senão, coloca a data selecionada como a primeira data do calendário
    final now = DateTime.now();
    if (now.isAfter(currentPeriodo.inicio) && now.isBefore(currentPeriodo.termino)) {
      selectedDate = now;
      mes = selectedDate.month;
    } else {
      selectedDate = currentPeriodo.inicio;
      mes = currentPeriodo.inicio.month;
    }
  }

  setMes(int mes) => this.mes = mes;

  incMes() {
    final n = DateTime.now();
    if (mes < currentPeriodo.termino.month) {
      this.mes++;
      final d = currentCalendario.dates.firstWhere((d) => isSameDay(d.date, n), orElse: () => null);
      if (d != null) {
        selectedDate = d.date;
      } else {
        selectedDate = currentCalendario.dates.first.date;
      }
    }
  }

  decMes() {
    final n = DateTime.now();

    if (mes > currentPeriodo.inicio.month) {
      this.mes--;
      final d = currentCalendario.dates.firstWhere((d) => isSameDay(d.date, n), orElse: () => null);
      if (d != null) {
        selectedDate = d.date;
      } else {
        selectedDate = currentCalendario.dates.first.date;
      }
    }
  }

  ///Data selecionada via CalendarioCellStrip
  setSelectedDate(DateTime newDate) => selectedDate = newDate;

  DataDTO get aulasDia {
    return currentCalendario.dates.firstWhere((d) => isSameDay(d.date, selectedDate));
  }

  CalendarioDTO get currentCalendario => currentPeriodo.getCalendarioByMonth(mes);

  bool hasProva() {
    final List<Notas> listNotas = [];
    currentPeriodo.materias.forEach((m) => m.notas.forEach((n) => listNotas.add(n)));
    return listNotas.firstWhere((l) => isSameDay(l.data, selectedDate), orElse: () => null) != null;
  }

  List<AulasSemanaDTO> get aulasByWeekDay {
    final aulas =
        currentPeriodo.aulasSemana.where((m) => m.weekDay == getWeekday(selectedDate)).toList();

    final List<AulasSemanaDTO> resultAulas = [];
    aulas
        .where((AulasSemanaDTO a) => a.idMateria != null)
        .map((AulasSemanaDTO a) => a.idMateria)
        .toSet()
        .forEach((int id) => resultAulas.add(aulas.firstWhere((it) => it.idMateria == id)));

    return resultAulas;
  }

  List<AulasSemanaDTO> get aulasAgendaveis {
    ///Lista [aulas] por [dia da semana]
    final aulas =
        currentPeriodo.aulasSemana.where((m) => m.weekDay == getWeekday(selectedDate)).toList();

    ///lista [aulas] já agendadas para determinado dia
    final aulasAgendadas =
        currentPeriodo.extractNotasByDate(selectedDate).map((n) => n.idMateria).toSet();

    ///remove [aulas] já agendadas
    aulas.removeWhere((a) => aulasAgendadas.contains(a.idMateria));

    final List<AulasSemanaDTO> resultAulas = [];
    aulas
        .where((AulasSemanaDTO a) => a.idMateria != null)
        .map((AulasSemanaDTO a) => a.idMateria)
        .toSet()
        .forEach((int id) => resultAulas.add(aulas.firstWhere((it) => it.idMateria == id)));

    return resultAulas;
  }

  List<ProvasNotasMaterias> get provasNotasByDate {
    final notas = currentPeriodo.extractNotasByDate(selectedDate);

    final List<ProvasNotasMaterias> provasNotasMaterias = [];

    for (final n in notas) {
      provasNotasMaterias.add(
        ProvasNotasMaterias(
          nota: n,
          materia: currentPeriodo.getMateriaById(n.idMateria),
        ),
      );
    }

    return provasNotasMaterias;
  }

  PeriodosPosicao get periodosPosicao {
    return PeriodosPosicao(
      periodos: periodos,
      currentPeriodoPos: periodos.indexWhere((i) => i.id == _currentId),
    );
  }

  removePeriodoById(int idPeriodo) {
    periodos.remove(periodos.firstWhere((it) => it.id == idPeriodo));
    setCurrentPeriodoId(periodos.first.id);
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

  insertFalta(Faltas falta) {
    currentPeriodo.insertFalta(falta);
    currentCalendario.insertFalta(falta);
  }

  deleteFalta(int idMateria, int idFalta, DateTime date) {
    currentPeriodo.deleteFalta(idMateria, idFalta);
    currentCalendario.deleteFalta(date, idFalta);
  }

  insertNota(Notas nota) {
    currentPeriodo.insertNota(nota);
  }

  deleteNota(Notas nota) {
    currentPeriodo.deleteNota(nota);
  }

  updateNota(Notas nota) {
    currentPeriodo.updateNota(nota);
  }
}
