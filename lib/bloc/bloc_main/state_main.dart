import 'package:curso/models/aulas.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class StateMain {
  StateMain({
    @required this.periodos,
  }) {
    _currentId = periodos.first.id;
    _positionDates();
  }

  List<Periodos> periodos;
  int _currentId, mes;
  DateTime selectedDate;

  void _positionDates() {
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

  void setCurrentPeriodoId(int idPeriodo) {
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

  void incMes() {
    final n = DateTime.now();
    if (mes < currentPeriodo.termino.month) {
      mes++;
      final d = currentCalendario.dates.firstWhere((d) => isSameDay(d.date, n), orElse: () => null);
      if (d != null) {
        selectedDate = d.date;
      } else {
        selectedDate = currentCalendario.dates.first.date;
      }
    }
  }

  void decMes() {
    final n = DateTime.now();

    if (mes > currentPeriodo.inicio.month) {
      mes--;
      final d = currentCalendario.dates.firstWhere((d) => isSameDay(d.date, n), orElse: () => null);
      if (d != null) {
        selectedDate = d.date;
      } else {
        selectedDate = currentCalendario.dates.first.date;
      }
    }
  }

  ///Data selecionada via CalendarioCellStrip
  void setSelectedDate(DateTime newDate) => selectedDate = newDate;

  DataDTO get aulasDia {
    return currentCalendario.dates.firstWhere((d) => isSameDay(d.date, selectedDate));
  }

  CalendarioDTO get currentCalendario => currentPeriodo.getCalendarioByMonth(mes);

  bool hasProva() {
    final List<Notas> listNotas = [];
    currentPeriodo.materias.forEach((m) => m.notas.forEach(listNotas.add));
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

  void removePeriodoById(int idPeriodo) {
    periodos.remove(periodos.firstWhere((it) => it.id == idPeriodo));
    setCurrentPeriodoId(periodos.first.id);
  }

  void addPeriodo(Periodos p) {
    periodos.add(p);
  }

  void updatePeriodo(Periodos p) {
    final int index = periodos.indexWhere((it) => it.id == p.id);
    periodos[index] = p..refreshCalendario();

    if (isBetween(DateTime.now(), currentPeriodo.inicio, currentPeriodo.termino)) {
      selectedDate = DateTime.now();
      mes = DateTime.now().month;
    } else {
      selectedDate = currentPeriodo.inicio;
      mes = currentPeriodo.inicio.month;
    }
  }

  void _refreshCalendario(int idPeriodo) {
    periodos.firstWhere((it) => it.id == idPeriodo)
      ..refreshCalendario()
      ..prepareParciais();
  }

  void refreshMaterias(int idPeriodo, List<Materias> materias) {
    periodos.firstWhere((it) => it.id == idPeriodo).materias = materias;
    _refreshCalendario(idPeriodo);
  }

  void insertAula(int idPeriodo, int idMateria, Aulas aula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .firstWhere((it) => it.id == idMateria)
        .aulas
        .add(aula);

    _refreshCalendario(idPeriodo);
  }

  void deleteAula(int idPeriodo, int idAula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .forEach((m) => m.aulas.removeWhere((it) => it.id == idAula));

    _refreshCalendario(idPeriodo);
  }

  void insertFalta(Faltas falta) {
    currentPeriodo.insertFalta(falta);
    currentCalendario.insertFalta(falta);
  }

  void deleteFalta(int idMateria, int idFalta, DateTime date, int tipoFalta) {
    currentPeriodo.deleteFalta(idMateria, idFalta, tipoFalta);
    currentCalendario.deleteFalta(date, idFalta);
  }

  void insertNota(Notas nota) {
    currentPeriodo.insertNota(nota);
  }

  void deleteNota(Notas nota) {
    currentPeriodo.deleteNota(nota);
  }

  void updateNota(Notas nota) {
    currentPeriodo.updateNota(nota);
  }

  Parciais get provideParciais => currentPeriodo.parciais;
}
