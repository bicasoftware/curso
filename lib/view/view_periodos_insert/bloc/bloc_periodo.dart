import 'package:curso/bloc/base_bloc.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/flux.dart';
import 'package:meta/meta.dart';

class BlocPeriodo extends BaseBloc {
  BlocPeriodo({@required Periodos periodo}) {
    _periodo = periodo;
    numPeriodo = Flux(periodo.numperiodo);
    aulasDia = Flux(periodo.aulasdia);
    medAprov = Flux(periodo.medaprov);
    presObrig = Flux(periodo.presObrig.toDouble());
    inicio = Flux(periodo.inicio);
    termino = Flux(periodo.termino);
    horarios = Flux([for (final h in periodo.horarios) h.getCopy()]);
  }

  Periodos _periodo;
  bool shouldUpdate = false;

  Flux<int> numPeriodo, aulasDia;
  Flux<double> medAprov, presObrig;
  Flux<DateTime> inicio, termino;
  Flux<List<Horarios>> horarios;

  @override
  void dispose() {
    numPeriodo.close();
    inicio.close();
    termino.close();
    medAprov.close();
    presObrig.close();
    aulasDia.close();
    horarios.close();
  }

  bool _temHorarioSalvo(int i) {
    return horarios.value?.firstWhere((h) => h.ordemaula == i, orElse: () => null) != null;
  }

  void setAulasDia(int dia) {
    aulasDia.set(dia);
    for (var i = 0; i < aulasDia.value; i++) {
      if (!_temHorarioSalvo(i)) {
        horarios.value.add(
          Horarios(
            id: null,
            idPeriodo: _periodo.id,
            inicio: _periodo.horarios.last.termino,
            termino: _periodo.horarios.last.termino.add(const Duration(minutes: 50)),
            ordemaula: i,
          ),
        );

        horarios.set(horarios.value);
      }
    }
  }

  void setHoraAula(int ordemAula, DateTime inicio, DateTime termino) {
    final int index = horarios.value.indexWhere((h) => h.ordemaula == ordemAula);

    if (index < 0) {
      horarios.value.add(
        Horarios(idPeriodo: _periodo.id, inicio: inicio, termino: termino, ordemaula: ordemAula),
      );
    } else {
      horarios.value
        ..removeAt(index)
        ..add(
          Horarios(
            idPeriodo: _periodo.id,
            inicio: inicio,
            termino: termino,
            ordemaula: ordemAula,
          ),
        );
      horarios.set(horarios.value);
    }
  }

  bool hasChanged() {
    if (numPeriodo.hasChanged ||
        aulasDia.hasChanged ||
        medAprov.hasChanged ||
        presObrig.hasChanged ||
        inicio.hasChanged ||
        termino.hasChanged ||
        horarios.hasChanged) {
      return true;
    }
    return false;
  }

  Periodos providePeriodo() {
    if (shouldUpdate) {
      _periodo
        ..numperiodo = numPeriodo.value
        ..aulasdia = aulasDia.value
        ..medaprov = medAprov.value
        ..presObrig = presObrig.value.toInt()
        ..inicio = inicio.value
        ..termino = termino.value
        ..horarios = [for (final h in horarios.value) h.getCopy()];
    }

    return _periodo;
  }
}
