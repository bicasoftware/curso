import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario_content.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/providers/provider_aulas.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:rxdart/rxdart.dart';

import 'state_main.dart';

class BlocMain implements BlocBase {
  StateMain state;

  BehaviorSubject<int> _subjectPerPos = BehaviorSubject<int>();
  get outPerPos => _subjectPerPos.stream;

  BehaviorSubject<Periodos> _subjectCurrentPeriodo = BehaviorSubject<Periodos>();
  Stream<Periodos> get outCurrentPeriodo => _subjectCurrentPeriodo.stream;
  get inCurrentPeriodo => _subjectCurrentPeriodo.sink;

  final _subSelectedDate = BehaviorSubject<DateTime>();
  Stream<DateTime> get outSelectedDate => _subSelectedDate.stream;
  get inSelectedDate => _subSelectedDate.sink;

  final _subDataDTO = BehaviorSubject<DataDTO>();
  get outDataDTO => _subDataDTO.stream;
  get inDataDTO => _subDataDTO.sink;

  final _subjectPeriodosLabel = BehaviorSubject<List<Pair<int, int>>>();
  get outPeriodosLabel => _subjectPeriodosLabel.stream;
  get inPeriodosLabel => _subjectPeriodosLabel.sink;

  BehaviorSubject<int> _subjectMes = BehaviorSubject<int>();
  get outMes => _subjectMes.stream;
  get inMes => _subjectMes.sink;

  BehaviorSubject<List<Periodos>> _subjectPeriodos = BehaviorSubject<List<Periodos>>();
  get outPeriodos => _subjectPeriodos.stream;
  get inPeriodos => _subjectPeriodos.sink;

  BehaviorSubject<Conf> _subjectConf = BehaviorSubject<Conf>();
  get outConf => _subjectConf.stream;
  get inConf => _subjectConf.sink;

  BehaviorSubject<int> _subPosition = BehaviorSubject<int>();
  get outPos => _subPosition.stream;
  get inPos => _subPosition.sink;

  BehaviorSubject<AppBrightness> _subjectBrightness = BehaviorSubject<AppBrightness>();
  get outBrightness => _subjectBrightness.stream;
  get inBrightness => _subjectBrightness.sink;

  final _subCalendarioContent = BehaviorSubject<CalendarioDTO>();
  Stream<CalendarioDTO> get outCalendario => _subCalendarioContent.stream;
  Sink<CalendarioDTO> get inCalendario => _subCalendarioContent.sink;

  BlocMain({
    List<Periodos> periodos,
    Conf conf,
    int pos,
    int periodoAtual,
  }) {
    this.state = StateMain(
      periodos: periodos,
      conf: conf,
      pos: pos,
      periodoPos: periodoAtual,
    );

    _sinkPos();
    _sinkPeriodos();
    _sinkCurrentPeriodo();
    _sinkConf();
    inMes.add(state.mes);
  }

  @override
  void dispose() {
    _subjectPeriodos.close();
    _subjectConf.close();
    _subPosition.close();
    _subjectBrightness.close();
    _subjectPerPos.close();
    _subjectCurrentPeriodo.close();
    _subjectPeriodosLabel.close();
    _subjectMes.close();
    _subCalendarioContent.close();
    _subDataDTO.close();
    _subSelectedDate.close();
  }

  _sinkPeriodos() {
    inPeriodos.add(state.periodos);
    inCalendario.add(state.daysOfMonth);
  }

  _sinkCurrentPeriodo() {
    inCurrentPeriodo.add(state.currentPeriodo);
    inPeriodosLabel.add(state.periodosLabels);
    inCalendario.add(state.daysOfMonth);
    inDataDTO.add(state.aulasDia);
    inMes.add(state.mes);
    inSelectedDate.add(state.selectedDate);
  }

  _sinkMes() {
    inMes.add(state.mes);
    inCalendario.add(state.daysOfMonth);
  }

  _sinkConf() => inConf.add(state.conf);

  _sinkPos() => inPos.add(state.pos);

  _sinkBrightness() => inBrightness.add(state.conf.brightness);

  setPosition(int pos) {
    state.pos = pos;
    _sinkPos();
  }

  incMes() {
    state.incMes();
    _sinkMes();
  }

  decMes() {
    state.decMes();
    _sinkMes();
  }

  setPeriodoPosition(int pos) {
    state.periodoPos = pos;
    _sinkCurrentPeriodo();
  }

  setNotify(bool notify) {
    state.setNotify(notify);
    _sinkConf();
  }

  setBrightness(AppBrightness brightness) {
    state.setBrightness(brightness);
    _sinkBrightness();
  }

  setCurrentPeriodo(int periodoPos) {
    state.setPeriodoPos(periodoPos);
    _sinkCurrentPeriodo();
  }

  setCurrentDate(DateTime date) {
    state.setDate(date);
    _sinkCurrentPeriodo();
  }

  incCurrentDate() {
    state.incDate();
    _sinkCurrentPeriodo();
  }

  decCurrentDate() {
    state.decDate();
    _sinkCurrentPeriodo();
  }

  Stream<List<Object>> getPeriodoDate() {
    return ZipStream(
      [outCurrentPeriodo, outSelectedDate],
      (a) {
        return []..addAll(a);
      },
    );
  }

  updatePeriodo(Periodos periodo) {
    ProviderPeriodos.updatePeriodo(periodo)
        .then((Periodos p) => state.updatePeriodo(p))
        .whenComplete(() => _sinkPeriodos());
  }

  insertPeriodo(Periodos periodo) {
    ProviderPeriodos.insertPeriodo(periodo)
        .then((Periodos p) => state.addPeriodo(p))
        .whenComplete(() => _sinkPeriodos());
  }

  deletePeriodo(int idPeriodo) {
    ProviderPeriodos.deletePeriodo(idPeriodo)
        .then((a) => state.removePeriodoById(idPeriodo))
        .whenComplete(() => _sinkPeriodos());
  }

  updateMaterias(int idPeriodo, List<Materias> materias) {
    ///Não há chamadas ao banco, pois as queries são chamadas via ViewInsertMaterias
    ///Aqui ocorre somente a atualização dos resultados vindos de ViewMaterias
    state.refreshMaterias(idPeriodo, materias);
  }

  insertAula({int idPeriodo, int idMateria, int weekDay, int ordemAula}) {
    var aula =
        Aulas(idPeriodo: idPeriodo, idMateria: idMateria, weekDay: weekDay, ordem: ordemAula);
    ProviderAulas.insertAulas(aula)
        .then((Aulas a) => state.insertAula(idPeriodo, idMateria, aula))
        .whenComplete(() => _sinkPeriodos());
  }

  deleteAula({int idAula, int idPeriodo}) {
    ProviderAulas.deleteAulasById(idAula)
        .then((a) => state.deleteAula(idPeriodo, idAula))
        .whenComplete(() => _sinkPeriodos());
  }

  updateAula({int idAula, int idPeriodo, int idMateria, int weekDay, int ordemAula}) {
    var aula = Aulas(
      idPeriodo: idPeriodo,
      idMateria: idMateria,
      weekDay: weekDay,
      ordem: ordemAula,
    );

    Future.wait([
      ProviderAulas.deleteAulasById(idAula),
      ProviderAulas.insertAulas(aula),
    ]).then((List<Object> results) {
      state.deleteAula(idPeriodo, idAula);
      state.insertAula(idPeriodo, idMateria, results[1]);
    }).whenComplete(() => _sinkPeriodos());
  }
}
