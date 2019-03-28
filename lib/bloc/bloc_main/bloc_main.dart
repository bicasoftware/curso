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
import 'package:rxdart/rxdart.dart';

import 'state_main.dart';

class BlocMain implements BlocBase {
  StateMain state;

  final _subDataDTO = BehaviorSubject<DataDTO>();
  get outDataDTO => _subDataDTO.stream;
  get inDataDTO => _subDataDTO.sink;

  BehaviorSubject<int> _subjectMes = BehaviorSubject<int>();
  get outMes => _subjectMes.stream;
  get inMes => _subjectMes.sink;

  BehaviorSubject<List<Periodos>> _subjectPeriodos = BehaviorSubject<List<Periodos>>();
  get outPeriodos => _subjectPeriodos.stream;
  get inPeriodos => _subjectPeriodos.sink;

  BehaviorSubject<Conf> _subjectConf = BehaviorSubject<Conf>();
  get outConf => _subjectConf.stream;
  get inConf => _subjectConf.sink;

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
  }) {
    this.state = StateMain(
      periodos: periodos,
    );

    _sinkPeriodos();
    _sinkCurrentPeriodo();
    inMes.add(state.mes);
  }

  @override
  void dispose() {
    _subjectPeriodos.close();
    _subjectConf.close();
    _subjectBrightness.close();
    _subjectMes.close();
    _subCalendarioContent.close();
    _subDataDTO.close();
  }

  _sinkPeriodos() {
    inPeriodos.add(state.periodos);
    inCalendario.add(state.currentCalendario);
  }

  _sinkCurrentPeriodo() {
    inCalendario.add(state.currentCalendario);
    inDataDTO.add(state.aulasDia);
    inMes.add(state.mes);
  }

  incMes() {
    state.incMes();
    _sinkCurrentPeriodo();
  }

  decMes() {
    state.decMes();
    _sinkCurrentPeriodo();
  }

  setCurrentPeriodoId(int idPeriodo) {
    state.setCurrentPeriodoId(idPeriodo);
    _sinkCurrentPeriodo();
  }

  setCurrentDate(DateTime date) {
    state.setSelectedDate(date);
    _sinkCurrentPeriodo();
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
