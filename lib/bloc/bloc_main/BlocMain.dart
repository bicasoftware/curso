import 'package:bloc/bloc.dart';
import 'package:curso/container/faltas.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/main_state.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/events/events_main/MainEvents.dart';
import 'package:curso/utils.dart/AppBrightness.dart';

class BlocMain extends Bloc<MainEvents, MainState> {
  @override
  MainState get initialState {
    return MainState(
      navPos: 0,
      periodos: [
        Periodos(
          id: 1,
          inicio: DateTime(2019, 01, 12),
          termino: DateTime(2019, 06, 01),
          aulasDia: 4,
          medAprov: 7.0,
          presObrig: 75,
          materias: [
            Materias(
              id: 1,
              idPeriodo: 1,
              nome: "Matemática",
              sigla: "MAT",
              freq: true,
              medAprov: 7.0,
              faltas: [
                Faltas(
                  id: 1,
                  idMateria: 1,
                  numAula: 1,
                  data: DateTime(2019, 2, 16),
                ),
                Faltas(
                  id: 2,
                  idMateria: 1,
                  numAula: 2,
                  data: DateTime(2019, 2, 16),
                ),
              ],
              notas: [
                Notas(
                  id: 1,
                  idMateria: 1,
                  nota: 9.5,
                  data: DateTime(2019, 03, 02),
                ),
                Notas(
                  id: 2,
                  idMateria: 1,
                  nota: 8,
                  data: DateTime(2019, 04, 12),
                )
              ],
            ),
          ],
        )
      ],
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
