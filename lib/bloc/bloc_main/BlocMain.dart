import 'package:bloc/bloc.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class BlocMain extends Bloc<MainEvents, MainState> {
  final List<Periodos> periodos;
  final Conf conf;

  BlocMain({this.periodos, this.conf}): super();

  @override
  MainState get initialState {
    return MainState(
      brightness: conf.brightness ?? AppBrightness.DARK,
      notify: conf.notify,
      periodos: periodos,
      navPos: 0,
    );
  }

  @override
  Stream<MainState> mapEventToState(MainState currentState, MainEvents event) async* {
    if (event is SetPosition) {
      yield currentState.copyWith(navPos: event.pos);
    } else if (event is SetNotify) {
      yield currentState.copyWith(notify: event.notify);
    } else if (event is SetBrightness) {
      yield currentState.copyWith(brightness: event.brightness);
    } else if (event is UpdatePeriodo) {
      await ProviderPeriodos.updatePeriodo(event.periodo);
      final periodos = currentState.periodos;
      final index = periodos.indexWhere((it) => it.id == event.periodo.id);
      periodos[index] = periodos[index].copyWith(oldPeriodo: event.periodo);
      yield currentState.copyWith(periodos: periodos);
    } else if (event is InsertPeriodo) {
      final p = await ProviderPeriodos.insertPeriodo(event.periodo);
      yield currentState.copyWith(periodos: currentState.periodos..add(p));
    } else if(event is RefreshMaterias){
      final List<Periodos> periodos = []..addAll(currentState.periodos);
      final index = periodos.indexWhere((Periodos p) => p.id == event.idPeriodo);
      periodos[index] = periodos[index].copyWith(materias: []..addAll(event.materias));
      yield currentState.copyWith(periodos: []..addAll(periodos));
    }
  }
}
