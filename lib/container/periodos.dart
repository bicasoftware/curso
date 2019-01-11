import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/container/materias.dart';

class Periodos implements BaseTable {
  final int id, presObrig, aulasDia;
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
    this.aulasDia,
  });

  static const String ID = "id";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";
  static const String PRESOBRIG = "pres_obrig";
  static const String MEDAPROV = "med_aprov";
  static const String AULASDIA = "aulas_dia";

  Periodos copyWith(
    DateTime inicio,
    DateTime termino,
    int presObrig,
    double medAprov,
    int aulasDia,
    List<Materias> materias,
  ) {
    return Periodos(
      id: id ?? this.id,
      inicio: inicio ?? this.inicio,
      termino: termino ?? this.termino,
      presObrig: presObrig ?? this.presObrig,
      medAprov: medAprov ?? this.medAprov,
      aulasDia: aulasDia ?? this.aulasDia,
      materias: materias ?? this.materias,
    );
  }

  static List<String> provideColumns = [
    ID,
    INICIO,
    TERMINO,
    PRESOBRIG,
    MEDAPROV,
    AULASDIA,
  ];

  static String tableName = "periodos";

  static String getCreateSQL() {
    return """create table $tableName(
    $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    $INICIO TEXT NOT NULL DEFAULT "",
    $TERMINO TEXT NOT NULL DEFAULT "",
    $PRESOBRIG INTEGER NOT NULL DEFAULT 75,
    $MEDAPROV REAL NOT NULL DEFAULT 5.0,
    $AULASDIA INTEGER NOT NULL DEFAULT 1
    );""";
  }

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      INICIO: Formatting.formatDbDate(inicio),
      TERMINO: Formatting.formatDbDate(termino),
      PRESOBRIG: presObrig,
      MEDAPROV: medAprov,
      AULASDIA: aulasDia,
    };

    if (id != null) m[ID] = id;

    return m;
  }

  static Periodos fromMap(Map m) {
    return Periodos(
      id: m[ID],
      inicio: Formatting.parseDate(m[INICIO]),
      termino: Formatting.parseDate(m[TERMINO]),
      presObrig: m[PRESOBRIG],
      medAprov: m[MEDAPROV],
      aulasDia: m[AULASDIA],
    );
  }
}
