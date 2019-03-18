import 'package:curso/container/aulas.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/utils.dart/ListUtils.dart';
import 'package:meta/meta.dart';

class StateMain {
  List<Periodos> periodos;
  Conf conf;
  int pos, periodoPos, mes;
  DateTime selectedDate;

  StateMain({
    @required this.periodos,
    @required this.conf,
    @required this.pos,
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

  setBrightness(AppBrightness br) => conf.brightness = br;

  setNotify(bool notify) => conf.notify = notify;

  setPeriodoPos(int periodoPos) => periodoPos = periodoPos;

  Periodos get currentPeriodo => periodos[periodoPos];

  get periodosLabels =>
      periodos.map((p) => Pair<int, int>(first: p.id, second: p.numPeriodo)).toList();

  setMes(int mes) => this.mes = mes;

  incMes() {
    if (mes < currentPeriodo.termino.month) this.mes++;
  }

  decMes() {
    if (mes > currentPeriodo.inicio.month) this.mes--;
  }

  setDate(DateTime newDate) {
    selectedDate = newDate;
  }

  incDate() {
    final nextDate = selectedDate.add(Duration(days: 1));
    if (!nextDate.isAfter(currentPeriodo.termino)) {
      selectedDate = nextDate;
      mes = selectedDate.month;
    }
  }

  decDate() {
    final nextDate = selectedDate.subtract(Duration(days: 1));
    if (!nextDate.isBefore(currentPeriodo.inicio)) {
      selectedDate = nextDate;
      mes = selectedDate.month;
    }
  }

  get aulasDia => Pair(first: currentPeriodo, second: selectedDate);

  Pair<int, List<DateTime>> get daysOfMonth =>
      periodos[periodoPos].calendario.firstWhere((it) => it.first == mes);

  removePeriodoById(int idPeriodo) {
    periodos.remove(periodos.firstWhere((it) => it.id == idPeriodo));
  }

  addPeriodo(Periodos p) {
    periodos.add(p);
  }

  updatePeriodo(Periodos p) {
    int index = periodos.indexWhere((it) => it.id == p.id);
    periodos[index] = p;
  }

  refreshMaterias(int idPeriodo, List<Materias> materias) {
    periodos.firstWhere((it) => it.id == idPeriodo).materias = materias;
  }

  insertAula(int idPeriodo, int idMateria, Aulas aula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .firstWhere((it) => it.id == idMateria)
        .aulas
        .add(aula);
  }

  deleteAula(int idPeriodo, int idAula) {
    periodos
        .firstWhere((it) => it.id == idPeriodo)
        .materias
        .forEach((m) => m.aulas.removeWhere((it) => it.id == idAula));
  }
}
