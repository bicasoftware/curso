import 'package:bloc/bloc.dart';
import 'package:curso/MainState.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';

class BlocMain extends Bloc<MainEvents, MainState> {
  @override
  MainState get initialState => MainState(navPos: 0, periodos: List<Periodos>());

  @override
  Stream<MainState> mapEventToState(MainState currentState, MainEvents event) async* {
    if (event is SetPosition) {
      yield currentState.copyWith(navPos: event.pos);
    }
  }
}
