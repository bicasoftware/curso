import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/container/periodos.dart';
import 'package:rxdart/rxdart.dart';

import 'state_provas.dart';

class BlocProvas implements Bloc {
  StateProvas state;

  BlocProvas(Periodos periodo) {
    this.state = StateProvas(periodo);
    inFaltas.add(state.provas);
  }

  BehaviorSubject<List<NotasContainer>> _subjectFaltas = BehaviorSubject<List<NotasContainer>>();
  get outFaltas => _subjectFaltas.stream;
  get inFaltas => _subjectFaltas.sink;

  @override
  void dispose() {
    _subjectFaltas.close();
  }

  updateProva(Notas nota){
    state.updateProva(nota);
    inFaltas.add(state.provas);
  }
}
