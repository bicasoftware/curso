import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/Formatting.dart';
import 'package:curso/container/materias.dart';

class Periodos implements BaseTable {
  int id, presObrig, aulasDia;
  DateTime inicio, termino;
  double medAprov;
  List<Materias> materias;

  Periodos({
    this.id,
    this.inicio,
    this.termino,
    this.presObrig,
    this.medAprov,
    this.materias: const [],
    this.aulasDia,
  });

  static const String ID = "id";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";
  static const String PRESOBRIG = "pres_obrig";
  static const String MEDAPROV = "med_aprov";
  static const String AULASDIA = "aulas_dia";

  static Periodos newInstance() {
    final now = DateTime.now();
    final end = now.add(Duration(days: 6 * 30));
    return Periodos(
      inicio: now,
      termino: end,
      presObrig: 75,
      aulasDia: 4,
      medAprov: 7.0,
      materias: [],
    );
  }

  // Periodos copyWith({
  //   Periodos oldPeriodo,
  //   int id,
  //   DateTime inicio,
  //   DateTime termino,
  //   int presObrig,
  //   double medAprov,
  //   int aulasDia,
  //   List<Materias> materias,
  // }) {
  //   if (oldPeriodo != null) {
  //     return Periodos(
  //       id: oldPeriodo.id ?? this.id,
  //       inicio: oldPeriodo.inicio ?? this.inicio,
  //       termino: oldPeriodo.termino ?? this.termino,
  //       presObrig: oldPeriodo.presObrig ?? this.presObrig,
  //       medAprov: oldPeriodo.medAprov ?? this.medAprov,
  //       aulasDia: oldPeriodo.aulasDia ?? this.aulasDia,
  //       materias: oldPeriodo.materias ?? this.materias,
  //     );
  //   } else {
  //     return Periodos(
  //       id: id ?? this.id,
  //       inicio: inicio ?? this.inicio,
  //       termino: termino ?? this.termino,
  //       presObrig: presObrig ?? this.presObrig,
  //       medAprov: medAprov ?? this.medAprov,
  //       aulasDia: aulasDia ?? this.aulasDia,
  //       materias: materias ?? this.materias,
  //     );
  //   }
  // }

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

  @override
  String toString() {
    return "${this.id},${this.inicio},${this.termino},${this.presObrig},${this.medAprov},${this.materias},${this.aulasDia}";
  }
}
