import 'package:curso/bloc/base_bloc.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:rxdart/rxdart.dart';

import 'state_provas.dart';

class BlocProvas implements BaseBloc {
  BlocProvas(Periodos periodo) {
    state = StateProvas(periodo);
    inFaltas.add(state.provas);
  }

  StateProvas state;

  final BehaviorSubject<List<NotasContainer>> _subjectFaltas =
      BehaviorSubject<List<NotasContainer>>();
  Stream<List<NotasContainer>> get outFaltas => _subjectFaltas.stream;
  Sink<List<NotasContainer>> get inFaltas => _subjectFaltas.sink;

  @override
  void dispose() {
    _subjectFaltas.close();
  }

  void updateProva(Notas nota) {
    state.updateProva(nota);
    inFaltas.add(state.provas);
  }
}
