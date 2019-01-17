import 'package:curso/container/aulas.dart';
import 'package:curso/database/base_table.dart';

import 'faltas.dart';
import 'notas.dart';

//adicionar array com ordem de aulas durante a semana

class Materias implements BaseTable {
  final int id, idPeriodo;
  final String nome, sigla;
  final bool freq;
  final double medAprov;
  final List<Faltas> faltas;
  final List<Notas> notas;
  final List<Aulas> aulas;

  Materias({
    this.id,
    this.idPeriodo,
    this.nome,
    this.sigla,
    this.freq,
    this.medAprov,
    this.faltas,
    this.notas,
    this.aulas,
  });

  static const String ID = "id";
  static const String IDPERIODO = "id_periodo";
  static const String NOME = "nome";
  static const String SIGLA = "sigla";
  static const String FREQ = "freq";
  static const String MEDAPROV = "med_aprov";

  Materias copyWith(
    int id,
    int idPeriodo,
    String nome,
    String sigla,
    bool freq,
    double medAprov,
    List<Notas> notas,
    List<Faltas> faltas,
    List<Aulas> aulas,
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
      aulas: aulas ?? this.aulas,
    );
  }

  static List<String> provideColumns = [
    ID,
    IDPERIODO,
    NOME,
    SIGLA,
    FREQ,
    MEDAPROV,
  ];

  static String tableName = "materias";

  static String getCreateSQL() {
    return """create table $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDPERIODO INTEGER NOT NULL,
      $NOME text NOT NULL DEFAULT "",
      $SIGLA text NOT NULL DEFAULT "",
      $FREQ INTEGER NOT NULL DEFAULT 1,
      $MEDAPROV REAL NOT NULL DEFAULT 5.0
    );""";
  }

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      IDPERIODO: idPeriodo,
      NOME: nome,
      SIGLA: sigla,
      FREQ: freq,
      MEDAPROV: medAprov,
    };

    if (id != null) m[ID] = id;

    return m;
  }

  static Materias fromMap(Map m) {
    return Materias(
      id: m[ID],
      idPeriodo: m[IDPERIODO],
      nome: m[NOME],
      sigla: m[SIGLA],
      medAprov: m[MEDAPROV],
      freq: m[FREQ],
    );
  }
}
