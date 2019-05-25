import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/container/aulas.dart';
import 'package:curso/container/calendario.dart';
import 'package:curso/container/calendario_strip_container.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/container/periodos_posicao.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/providers/provider_aulas.dart';
import 'package:curso/providers/provider_faltas.dart';
import 'package:curso/providers/provider_notas.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:rxdart/rxdart.dart';

import 'state_main.dart';

class BlocMain extends Bloc {
  StateMain state;
  int _pos;

  BehaviorSubject<int> _subjectPos = BehaviorSubject<int>();
  get outPos => _subjectPos.stream;
  get inPos => _subjectPos.sink;

  final _subDataDTO = BehaviorSubject<DataDTO>();
  get outDataDTO => _subDataDTO.stream;
  get inDataDTO => _subDataDTO.sink;

  BehaviorSubject<int> _subjectMes = BehaviorSubject<int>();
  get outMes => _subjectMes.stream;
  get inMes => _subjectMes.sink;

  BehaviorSubject<Periodos> _subjectCurrentPeriodo = BehaviorSubject<Periodos>();
  get outCurrentPeriodo => _subjectCurrentPeriodo.stream;
  get inCurrentPeriodo => _subjectCurrentPeriodo.sink;

  BehaviorSubject<List<Periodos>> _subjectListPeriodos = BehaviorSubject<List<Periodos>>();
  get outListPeriodos => _subjectListPeriodos.stream;
  get inListPeriodos => _subjectListPeriodos.sink;

  final _subjectPeriodos = BehaviorSubject<PeriodosPosicao>();
  Stream<PeriodosPosicao> get outPeriodos => _subjectPeriodos.stream;
  Sink<PeriodosPosicao> get inPeriodos => _subjectPeriodos.sink;

  final _subCalendarioContent = BehaviorSubject<CalendarioStripContainer>();
  Stream<CalendarioStripContainer> get outCalendario => _subCalendarioContent.stream;
  Sink<CalendarioStripContainer> get inCalendario => _subCalendarioContent.sink;

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

  BlocMain({
    List<Periodos> periodos,
    int pos,
  }) {
    this.state = StateMain(
      periodos: periodos,
    );

    _sinkPeriodos();
    _sinkCurrentPeriodo();
    inMes.add(state.mes);
    inPos.add(periodos.length > 0 ? 1 : 0);
  }

  @override
  void dispose() {
    _subjectPeriodos.close();
    _subjectMes.close();
    _subCalendarioContent.close();
    _subDataDTO.close();
    _subAulasAgendamento.close();
    _subProvasNotasMaterias.close();
    _subSelectedDate.close();
    _subjectPos.close();
    _subjectCurrentPeriodo.close();
    _subjectListPeriodos.close();
  }

  _sinkPeriodos() {
    inPeriodos.add(state.periodosPosicao);
    inListPeriodos.add(state.periodos);
    inCurrentPeriodo.add(state.currentPeriodo);
    inCalendario.add(
      CalendarioStripContainer(
        calendario: state.currentCalendario,
        selectedDate: state.selectedDate,
        initialOffset: state.calendarStripPosition,
      ),
    );
  }

  _sinkCurrentPeriodo() {
    inCalendario.add(
      CalendarioStripContainer(
        calendario: state.currentCalendario,
        selectedDate: state.selectedDate,
        initialOffset: state.calendarStripPosition,
      ),
    );
    inDataDTO.add(state.aulasDia);
    inMes.add(state.mes);
    inSelectedDate.add(state.selectedDate);
    inAulasAgendamento.add(state.aulasAgendaveis);
    inProvasNotasMaterias.add(Pair(first: state.provasNotasByDate, second: state.aulasByWeekDay));
    inCurrentPeriodo.add(state.currentPeriodo);
  }

  void setPos(int pos) {
    if (_pos != pos) {
      _pos = pos;
      inPos.add(_pos);
    }
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
      _sinkCurrentPeriodo();
    });
  }

  deleteFalta({int idMateria, int idFalta, DateTime date}) {
    ProviderFaltas.deleteFaltaById(idFalta)
        .then((_) => state.deleteFalta(idMateria, idFalta, date))
        .whenComplete(() => _sinkCurrentPeriodo());
  }

  insertNota(int idMateria) {
    final nota = Notas(id: null, nota: null, idMateria: idMateria, data: state.selectedDate);
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.insertNota(nota))
        .whenComplete(() => _sinkCurrentPeriodo());
  }

  updateNota(Notas nota) {
    ProviderNotas.upsertNota(nota)
        .then((Notas nota) => state.updateNota(nota))
        .whenComplete(() => _sinkCurrentPeriodo());
  }

  deleteNota(Notas nota) {
    ProviderNotas.deleteNota(nota)
        .then((_) => state.deleteNota(nota))
        .whenComplete(() => _sinkCurrentPeriodo());
  }
}
