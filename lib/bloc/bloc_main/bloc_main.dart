import 'dart:async';

import 'package:curso/bloc/base_bloc.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/models/aulas.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/materias.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/providers/provider_aulas.dart';
import 'package:curso/providers/provider_configuration.dart';
import 'package:curso/providers/provider_faltas.dart';
import 'package:curso/providers/provider_notas.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'state_main.dart';

class BlocMain extends BaseBloc {
  BlocMain({@required List<Periodos> periodos, @required bool isLight}) {
    state = StateMain(
      periodos: periodos,
    );

    _isLight = isLight;
    inBrightness.add(_isLight);
    _sinkPeriodos();
    _sinkCurrentPeriodo();
  }

  StateMain state;
  bool _isLight;

  final BehaviorSubject<bool> _bhsBrightness = BehaviorSubject<bool>();
  Stream<bool> get outBrightness => _bhsBrightness.stream;
  Sink<bool> get inBrightness => _bhsBrightness.sink;

  final _subDataDTO = BehaviorSubject<DataDTO>();
  Stream<DataDTO> get outDataDTO => _subDataDTO.stream;
  Sink<DataDTO> get inDataDTO => _subDataDTO.sink;

  final BehaviorSubject<Periodos> _subjectCurrentPeriodo = BehaviorSubject<Periodos>();
  Stream<Periodos> get outCurrentPeriodo => _subjectCurrentPeriodo.stream;
  Sink<Periodos> get inCurrentPeriodo => _subjectCurrentPeriodo.sink;

  final BehaviorSubject<List<Periodos>> _subjectListPeriodos = BehaviorSubject<List<Periodos>>();
  Stream<List<Periodos>> get outListPeriodos => _subjectListPeriodos.stream;
  Sink<List<Periodos>> get inListPeriodos => _subjectListPeriodos.sink;

  final _subProvasNotasMaterias =
      BehaviorSubject<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>>();

  Stream<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>> get outProvasNotasMaterias =>
      _subProvasNotasMaterias.stream;

  Sink<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>> get inProvasNotasMaterias =>
      _subProvasNotasMaterias.sink;

  final _subSelectedDate = BehaviorSubject<DateTime>();
  Stream<DateTime> get outSelectedDate => _subSelectedDate.stream;
  Sink<DateTime> get inSelectedDate => _subSelectedDate.sink;

  final _subAulasAgendamento = BehaviorSubject<List<AulasSemanaDTO>>();
  Stream<List<AulasSemanaDTO>> get outAulasAgendamento => _subAulasAgendamento.stream;
  Sink<List<AulasSemanaDTO>> get inAulasAgendamento => _subAulasAgendamento.sink;

  final BehaviorSubject<Parciais> _subjectParciais = BehaviorSubject<Parciais>();
  Stream<Parciais> get outParciais => _subjectParciais.stream;
  Sink<Parciais> get inParciais => _subjectParciais.sink;

  final BehaviorSubject<CalendarioDTO> _bhsCalendario = BehaviorSubject<CalendarioDTO>();
  Stream<CalendarioDTO> get outCalendario => _bhsCalendario.stream;
  Sink<CalendarioDTO> get inCalendario => _bhsCalendario.sink;

  @override
  void dispose() {
    _subDataDTO.close();
    _subAulasAgendamento.close();
    _subProvasNotasMaterias.close();
    _subSelectedDate.close();
    _subjectCurrentPeriodo.close();
    _subjectListPeriodos.close();
    _subjectParciais.close();
    _bhsCalendario.close();
    _bhsBrightness.close();
  }

  void toggleBrightness() async {
    _isLight = !_isLight;
    await ProviderConfiguration.putBrightness(_isLight).whenComplete(
      () => inBrightness.add(_isLight),
    );
  }

  void _sinkPeriodos() {
    inSelectedDate.add(state.selectedDate);
    inCalendario.add(state.currentCalendario);
    inParciais.add(state.provideParciais);
    inListPeriodos.add(state.periodos);
    inCurrentPeriodo.add(state.currentPeriodo);
  }

  void _sinkCurrentPeriodo() {
    inDataDTO.add(state.aulasDia);
    inSelectedDate.add(state.selectedDate);
    inCalendario.add(state.currentCalendario);
    inAulasAgendamento.add(state.aulasAgendaveis);
    inProvasNotasMaterias.add(Pair(first: state.provasNotasByDate, second: state.aulasByWeekDay));
    inCurrentPeriodo.add(state.currentPeriodo);
    inParciais.add(state.provideParciais);
  }

  void _sinkProva() {
    inCalendario.add(state.currentCalendario);
    inProvasNotasMaterias.add(
      Pair(first: state.provasNotasByDate, second: state.aulasByWeekDay),
    );
    inParciais.add(state.provideParciais);
    inAulasAgendamento.add(state.aulasAgendaveis);
  }

  void incMes() {
    state.incMes();
    _sinkCurrentPeriodo();
  }

  void decMes() {
    state.decMes();
    _sinkCurrentPeriodo();
  }

  void setCurrentPeriodoId(int idPeriodo) {
    state.setCurrentPeriodoId(idPeriodo);
    _sinkCurrentPeriodo();
  }

  void setCurrentDate(DateTime date) {
    state.setSelectedDate(date);
    _sinkCurrentPeriodo();
  }

  void updatePeriodo(Periodos periodo) {
    ProviderPeriodos.updatePeriodo(periodo)
        .then((Periodos p) => state.updatePeriodo(p))
        .whenComplete(_sinkPeriodos);
  }

  void insertPeriodo(Periodos periodo) {
    ProviderPeriodos.insertPeriodo(periodo)
        .then((Periodos p) => state.addPeriodo(p))
        .whenComplete(_sinkPeriodos);
  }

  void deletePeriodo(int idPeriodo) {
    ProviderPeriodos.deletePeriodo(idPeriodo)
        .then((a) => state.removePeriodoById(idPeriodo))
        .whenComplete(_sinkPeriodos);
  }

  void updateMaterias(int idPeriodo, List<Materias> materias) {
    state.refreshMaterias(idPeriodo, materias);
    _sinkPeriodos();
  }

  void insertAula({int idPeriodo, int idMateria, int weekDay, int ordemAula}) {
    final aula = Aulas(
      idPeriodo: idPeriodo,
      idMateria: idMateria,
      weekday: weekDay,
      ordem: ordemAula,
    );

    ProviderAulas.insertAulas(aula)
        .then((Aulas a) => state.insertAula(idPeriodo, idMateria, aula))
        .whenComplete(_sinkPeriodos);
  }

  void deleteAula({int idAula, int idPeriodo}) {
    ProviderAulas.deleteAulasById(idAula)
        .then((a) => state.deleteAula(idPeriodo, idAula))
        .whenComplete(_sinkPeriodos);
  }

  void updateAula({int idAula, int idPeriodo, int idMateria, int weekDay, int ordemAula}) {
    final aula = Aulas(
      idPeriodo: idPeriodo,
      idMateria: idMateria,
      weekday: weekDay,
      ordem: ordemAula,
    );

    Future.wait([
      ProviderAulas.deleteAulasById(idAula),
      ProviderAulas.insertAulas(aula),
    ]).then((List<Object> results) {
      state.deleteAula(idPeriodo, idAula);
      state.insertAula(idPeriodo, idMateria, results[1] as Aulas);
    }).whenComplete(_sinkPeriodos);
  }

  void _sinkFalta() {
    inCalendario.add(state.currentCalendario);
    inParciais.add(state.provideParciais);
    inDataDTO.add(state.aulasDia);
  }

  void insertFalta({int idMateria, int ordemAula, DateTime date, int tipo}) {
    ProviderFaltas.insertFalta(
      Faltas(
        id: null,
        idMateria: idMateria,
        ordemAula: ordemAula,
        data: date,
        tipo: tipo,
      ),
    ).then((Faltas f) {
      state.insertFalta(f);
    }).whenComplete(_sinkFalta);
  }

  void deleteFalta({
    @required int tipoFalta,
    int idMateria,
    int idFalta,
    DateTime date,
  }) {
    ProviderFaltas.deleteFaltaById(idFalta)
        .then((_) => state.deleteFalta(idMateria, idFalta, date, tipoFalta))
        .whenComplete(_sinkFalta);
  }

  void insertNota(int idMateria) {
    final nota = Notas(id: null, nota: null, idMateria: idMateria, data: state.selectedDate);
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.insertNota(nota))
        .whenComplete(_sinkProva);
  }

  void updateNota(Notas nota) {
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.updateNota(nota))
        .whenComplete(_sinkProva);
  }

  void deleteNota(Notas nota) {
    ProviderNotas.deleteNota(nota).then((_) => state.deleteNota(nota)).whenComplete(_sinkProva);
  }
}
