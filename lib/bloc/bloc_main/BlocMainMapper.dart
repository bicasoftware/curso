import 'package:curso/container/aulas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/providers/provider_aulas.dart';
import 'package:curso/providers/provider_periodos.dart';

class BlocMainMapper {
  static MainState setPosition(SetPosition event, MainState currentState) {
    return currentState.copyWith(navPos: event.pos);
  }

  static MainState setNotify(SetNotify event, MainState currentState) {
    return currentState.copyWith(notify: event.notify);
  }

  static MainState setBrightness(SetBrightness event, MainState currentState) {
    return currentState.copyWith(brightness: event.brightness);
  }

  static Future<MainState> updatePeriodo(UpdatePeriodo event, MainState currentState) async {
    await ProviderPeriodos.updatePeriodo(event.periodo);
    final periodos = currentState.periodos;
    final index = periodos.indexWhere((it) => it.id == event.periodo.id);
    periodos[index] = periodos[index].copyWith(oldPeriodo: event.periodo);
    return currentState.copyWith(periodos: periodos);
  }

  static Future<MainState> insertPeriodo(InsertPeriodo event, MainState currentState) async {
    final p = await ProviderPeriodos.insertPeriodo(event.periodo);
    final periodos = List<Periodos>()
      ..addAll(currentState.periodos)
      ..add(p);
    print(periodos.length);
    return currentState.copyWith(periodos: periodos);
  }

  static updateMaterias(RefreshMaterias event, MainState currentState) {
    final periodos = List<Periodos>()..addAll(currentState.periodos);
    final index = periodos.indexWhere((Periodos p) => p.id == event.idPeriodo);
    periodos[index] = periodos[index].copyWith(materias: []..addAll(event.materias));
    return currentState.copyWith(periodos: []..addAll(periodos));
  }

  static deletePeriodo(DeletePeriodo event, MainState currentState) async {
    await ProviderPeriodos.deletePeriodo(event.idPeriodo);

    final periodos = List<Periodos>()
      ..addAll(currentState.periodos)
      ..removeWhere((Periodos it) => it.id == event.idPeriodo);

    return currentState.copyWith(periodos: periodos);
  }

  static Future<MainState> insertAula(InsertAula event, MainState currentState) async {
    var aula = Aulas(idMateria: event.idMateria, weekDay: event.weekDay, ordem: event.ordemAula);
    aula = await ProviderAulas.upsertAulas(aula);

    //cria nova lista de periodos
    List<Periodos> periodos = []..addAll(currentState.periodos);

    Periodos periodo = periodos.firstWhere((it) => it.id == event.idPeriodo);

    //lista materia
    final List<Materias> materias = []..addAll(periodo.materias);

    //adiciona aula
    Materias m = materias.firstWhere((it) => it.id == event.idMateria);
    m = m.copyWith(aulas: []..addAll(m.aulas)..add(aula));

    final indexMateria = materias.indexWhere((it) => it.id == event.idMateria);
    materias[indexMateria] = m;

    periodo = periodo.copyWith(materias: materias);

    periodos[periodos.indexWhere((it) => it.id == event.idPeriodo)] = periodo;

    return currentState.copyWith(periodos: periodos);
  }

  static Future removeAula(DeleteAula event, MainState currentState) async {

    //todo - Debugar método!!!
    await ProviderAulas.deleteAulasById(event.idAula);

    //cria nova lista de periodos
    List<Periodos> periodos = []..addAll(currentState.periodos);

    Periodos periodo = periodos.firstWhere((it) => it.id == event.idPeriodo);

    //lista materia
    final List<Materias> materias = []..addAll(periodo.materias);

    //adiciona aula
    Materias m = materias.firstWhere((it) => it.id == event.idMateria);
    m = m.copyWith(aulas: []..addAll(m.aulas)..removeWhere((a) => a.id == event.idAula));

    final indexMateria = materias.indexWhere((it) => it.id == event.idMateria);
    materias[indexMateria] = m;

    periodo = periodo.copyWith(materias: materias);

    periodos[periodos.indexWhere((it) => it.id == event.idPeriodo)] = periodo;

    return currentState.copyWith(periodos: periodos);
  }
}
