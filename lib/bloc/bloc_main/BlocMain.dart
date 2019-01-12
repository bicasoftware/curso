import 'package:bloc/bloc.dart';
import 'package:curso/main_state.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class BlocMain extends Bloc<MainEvents, MainState> {
  @override
  MainState get initialState {
    return MainState(
      navPos: 0,
      periodos: List<Periodos>(),
      brightness: AppBrightness.DARK,
      notify: false,
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
    }
  }
}
