import 'package:curso/bloc/base_bloc.dart';
import 'package:curso/models/horarios.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/utils.dart/flux.dart';
import 'package:meta/meta.dart';

class BlocPeriodo extends BaseBloc {
  BlocPeriodo({@required Periodos periodo}) {
    _periodo = periodo;
    numPeriodo = Flux(periodo.numPeriodo);
    aulasDia = Flux(periodo.aulasDia);
    medAprov = Flux(periodo.medAprov);
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
    return horarios.value?.firstWhere((h) => h.ordemAula == i, orElse: () => null) != null;
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
            ordemAula: i,
          ),
        );

        horarios.set(horarios.value);
      }
    }
  }

  void setHoraAula(int ordemAula, DateTime inicio, DateTime termino) {
    final int index = horarios.value.indexWhere((h) => h.ordemAula == ordemAula);

    if (index < 0) {
      horarios.value.add(
        Horarios(idPeriodo: _periodo.id, inicio: inicio, termino: termino, ordemAula: ordemAula),
      );
    } else {
      horarios.value
        ..removeAt(index)
        ..add(
          Horarios(
            idPeriodo: _periodo.id,
            inicio: inicio,
            termino: termino,
            ordemAula: ordemAula,
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
        ..numPeriodo = numPeriodo.value
        ..aulasDia = aulasDia.value
        ..medAprov = medAprov.value
        ..presObrig = presObrig.value.toInt()
        ..inicio = inicio.value
        ..termino = termino.value
        ..horarios = [for (final h in horarios.value) h.getCopy()];
    }

    return _periodo;
  }
}
