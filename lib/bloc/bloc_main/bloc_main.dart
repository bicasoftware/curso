import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../../container/aulas.dart';
import '../../container/conf.dart';
import '../../container/materias.dart';
import '../../container/periodos.dart';
import '../../providers/provider_aulas.dart';
import '../../providers/provider_periodos.dart';
import '../../utils.dart/AppBrightness.dart';
import 'state_main.dart';

class BlocMain implements BlocBase {
  StateMain state;

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

  BlocMain({List<Periodos> periodos, Conf conf, int pos}) {
    this.state = StateMain(periodos: periodos, conf: conf, pos: pos);

    _sinkPeriodos();
    _sinkConf();
    _sinkPos();
  }

  @override
  void dispose() {
    _subjectPeriodos.close();
    _subjectConf.close();
    _subPosition.close();
    _subjectBrightness.close();
  }

  _sinkPeriodos() => inPeriodos.add(state.periodos);

  _sinkConf() => inConf.add(state.conf);

  _sinkPos() => inPos.add(state.pos);

  _sinkBrightness() => inBrightness.add(state.conf.brightness);

  setPosition(int pos) {
    state.pos = pos;
    _sinkPos();
  }

  setNotify(bool notify) {
    state.setNotify(notify);
    _sinkConf();
  }

  setBrightness(AppBrightness brightness) {
    state.setBrightness(brightness);
    _sinkBrightness();
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
    var aula = Aulas(idMateria: idMateria, weekDay: weekDay, ordem: ordemAula);
    ProviderAulas.upsertAulas(aula)
        .then((Aulas a) => state.insertAula(idPeriodo, idMateria, aula))
        .whenComplete(() => _sinkPeriodos());
  }

  deleteAula(int idAula, int idPeriodo, int idMateria) {
    ProviderAulas.deleteAulasById(idAula)
        .then((a) => state.deleteAula(idPeriodo, idMateria, idAula))
        .whenComplete(() => _sinkPeriodos());
  }
}
