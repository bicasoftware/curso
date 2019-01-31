import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
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
}
