import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/providers/provider_aulas.dart';
import 'package:curso/providers/provider_faltas.dart';
import 'package:curso/providers/provider_notas.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'state_main.dart';

class BlocMain extends Bloc {
  StateMain state;

  final _subDataDTO = BehaviorSubject<DataDTO>();
  get outDataDTO => _subDataDTO.stream;
  get inDataDTO => _subDataDTO.sink;

  BehaviorSubject<Periodos> _subjectCurrentPeriodo = BehaviorSubject<Periodos>();
  get outCurrentPeriodo => _subjectCurrentPeriodo.stream;
  get inCurrentPeriodo => _subjectCurrentPeriodo.sink;

  BehaviorSubject<List<Periodos>> _subjectListPeriodos = BehaviorSubject<List<Periodos>>();
  get outListPeriodos => _subjectListPeriodos.stream;
  get inListPeriodos => _subjectListPeriodos.sink;

  final _subProvasNotasMaterias =
      BehaviorSubject<Pair<List<ProvasNotasMaterias>, List<AulasSemanaDTO>>>();

  get outProvasNotasMaterias => _subProvasNotasMaterias.stream;
  get inProvasNotasMaterias => _subProvasNotasMaterias.sink;

  final _subSelectedDate = BehaviorSubject<DateTime>();
  Stream<DateTime> get outSelectedDate => _subSelectedDate.stream;
  Sink<DateTime> get inSelectedDate => _subSelectedDate.sink;

  final _subAulasAgendamento = BehaviorSubject<List<AulasSemanaDTO>>();
  Stream<List<AulasSemanaDTO>> get outAulasAgendamento => _subAulasAgendamento.stream;
  Sink<List<AulasSemanaDTO>> get inAulasAgendamento => _subAulasAgendamento.sink;

  BehaviorSubject<Parciais> _subjectParciais = BehaviorSubject<Parciais>();
  get outParciais => _subjectParciais.stream;
  get inParciais => _subjectParciais.sink;

  BehaviorSubject<CalendarioDTO> _bhsCalendario = BehaviorSubject<CalendarioDTO>();
  Stream<CalendarioDTO> get outCalendario => _bhsCalendario.stream;
  Sink<CalendarioDTO> get inCalendario => _bhsCalendario.sink;

  BlocMain({
    List<Periodos> periodos,
    int pos,
  }) {
    this.state = StateMain(
      periodos: periodos,
    );

    _sinkPeriodos();
    _sinkCurrentPeriodo();
  }

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
  }

  _sinkPeriodos() {
    inSelectedDate.add(state.selectedDate);
    inCalendario.add(state.currentCalendario);
    inParciais.add(state.provideParciais);
    inListPeriodos.add(state.periodos);
    inCurrentPeriodo.add(state.currentPeriodo);
  }

  _sinkCurrentPeriodo() {
    inDataDTO.add(state.aulasDia);
    inSelectedDate.add(state.selectedDate);
    inCalendario.add(state.currentCalendario);
    inAulasAgendamento.add(state.aulasAgendaveis);
    inProvasNotasMaterias.add(Pair(first: state.provasNotasByDate, second: state.aulasByWeekDay));
    inCurrentPeriodo.add(state.currentPeriodo);
    inParciais.add(state.provideParciais);
  }

  _sinkProva() {
    inCalendario.add(state.currentCalendario);
    inProvasNotasMaterias.add(
      Pair(first: state.provasNotasByDate, second: state.aulasByWeekDay),
    );
    inParciais.add(state.provideParciais);
    inAulasAgendamento.add(state.aulasAgendaveis);
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
    state.refreshMaterias(idPeriodo, materias);
    _sinkPeriodos();
  }

  insertAula({int idPeriodo, int idMateria, int weekDay, int ordemAula}) {
    final aula = Aulas(
      idPeriodo: idPeriodo,
      idMateria: idMateria,
      weekDay: weekDay,
      ordem: ordemAula,
    );

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

  _sinkFalta() {
    inCalendario.add(state.currentCalendario);
    inParciais.add(state.provideParciais);
    inDataDTO.add(state.aulasDia);
  }

  insertFalta({int idMateria, int ordemAula, DateTime date, int tipo}) async {
    ProviderFaltas.insertFalta(
      Faltas(
        id: null,
        idMateria: idMateria,
        numAula: ordemAula,
        data: date,
        tipo: tipo,
      ),
    ).then((Faltas f) {
      state.insertFalta(f);
    }).whenComplete(() {
      _sinkFalta();
    });
  }

  deleteFalta({int idMateria, int idFalta, DateTime date, @required int tipoFalta}) {
    ProviderFaltas.deleteFaltaById(idFalta)
        .then((_) => state.deleteFalta(idMateria, idFalta, date, tipoFalta))
        .whenComplete(() {
      _sinkFalta();
      //_sinkCurrentPeriodo();
    });
  }

  insertNota(int idMateria) {
    final nota = Notas(id: null, nota: null, idMateria: idMateria, data: state.selectedDate);
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.insertNota(nota))
        .whenComplete(() => _sinkProva());
  }

  updateNota(Notas nota) {
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.updateNota(nota))
        .whenComplete(() => _sinkProva());
  }

  deleteNota(Notas nota) {
    ProviderNotas.deleteNota(nota)
        .then((_) => state.deleteNota(nota))
        .whenComplete(() => _sinkProva());
  }
}
