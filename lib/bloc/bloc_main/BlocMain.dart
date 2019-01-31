import 'package:bloc/bloc.dart';
import 'package:curso/bloc/bloc_main/BlocMainMapper.dart';
import 'package:curso/container/conf.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/main_state.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/AppBrightness.dart';
import 'BlocMainMapper.dart' as mapper;

class BlocMain extends Bloc<MainEvents, MainState> {
  final List<Periodos> periodos;
  final Conf conf;

  BlocMain({this.periodos, this.conf}) : super();

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
      yield BlocMainMapper.setPosition(event, currentState);
    } else if (event is SetNotify) {
      yield BlocMainMapper.setNotify(event, currentState);
    } else if (event is SetBrightness) {
      yield BlocMainMapper.setBrightness(event, currentState);
      yield currentState.copyWith(brightness: event.brightness);
    } else if (event is UpdatePeriodo) {
      yield await BlocMainMapper.updatePeriodo(event, currentState);
    } else if (event is InsertPeriodo) {
      yield await BlocMainMapper.insertPeriodo(event, currentState);
    } else if (event is RefreshMaterias) {
      yield await BlocMainMapper.updateMaterias(event, currentState);
    } else if (event is DeletePeriodo) {
      yield await BlocMainMapper.deletePeriodo(event, currentState);
    }
  }
}
