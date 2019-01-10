import 'faltas.dart';
import 'notas.dart';

class Materias {
  final int id, idPeriodo;
  final String nome, sigla;
  final bool freq;
  final double medAprov;
  final List<Faltas> faltas;
  final List<Notas> notas;

  Materias({
    this.id,
    this.idPeriodo,
    this.nome,
    this.sigla,
    this.freq,
    this.medAprov,
    this.faltas,
    this.notas,
  });

  Materias copyWith(
    int id,
    int idPeriodo,
    String nome,
    String sigla,
    bool freq,
    double medAprov,
    List<Notas> notas,
    List<Faltas> faltas,
  ) {
    return Materias(
      id: id ?? this.id,
      idPeriodo: idPeriodo ?? this.idPeriodo,
      nome: nome ?? this.nome,
      sigla: sigla ?? this.sigla,
      freq: freq ?? this.freq,
      medAprov: medAprov ?? this.medAprov,
      faltas: faltas ?? this.faltas,
      notas: notas ?? this.notas,
    );
  }
}
