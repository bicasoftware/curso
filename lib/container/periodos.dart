import 'package:curso/container/materias.dart';

class Periodos {
  final int id, presObrig;
  final DateTime inicio, termino;
  final double medAprov;
  final List<Materias> materias;

  Periodos({
    this.id,
    this.inicio,
    this.termino,
    this.presObrig,
    this.medAprov,
    this.materias,
  });

  Periodos copyWith(
    DateTime inicio,
    DateTime termino,
    int presObrig,
    double medAprov,
    List<Materias> materias,
  ) =>
      Periodos(
        id: id ?? this.id,
        inicio: inicio ?? this.inicio,
        termino: termino ?? this.termino,
        presObrig: presObrig ?? this.presObrig,
        medAprov: medAprov ?? this.medAprov,
        materias: materias ?? this.materias,
      );
}
