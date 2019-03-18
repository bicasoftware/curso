import 'package:curso/container/horarios.dart';
import 'package:curso/database/base_table.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/pair.dart';

class Periodos implements BaseTable {
  int id, presObrig, aulasDia, numPeriodo;
  DateTime inicio, termino;
  double medAprov;
  List<Materias> materias;
  List<Horarios> horarios;
  List<Pair<int, List<DateTime>>> calendario;

  Periodos({
    this.id,
    this.numPeriodo,
    this.inicio,
    this.termino,
    this.presObrig,
    this.medAprov,
    this.materias,
    this.aulasDia,
  }) {
    materias = [];
    horarios = [];    
    //calendario = [];
    calendario = getDaysInRange(start: inicio, end: termino);
  }

  static const String ID = "id";
  static const String NUMPERIODO = "num_periodo";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";
  static const String PRESOBRIG = "pres_obrig";
  static const String MEDAPROV = "med_aprov";
  static const String AULASDIA = "aulas_dia";

  static Periodos newInstance() {
    final now = DateTime.now();
    final end = now.add(Duration(days: 6 * 30));
    return Periodos(
      numPeriodo: 1,
      inicio: now,
      termino: end,
      presObrig: 75,
      aulasDia: 4,
      medAprov: 7.0,
      materias: [],
    );
  }

  static List<String> provideColumns = [
    ID,
    NUMPERIODO,
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
    $NUMPERIODO INTEGER NOT NULL DEFAULT 1,
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
      NUMPERIODO: numPeriodo,
      INICIO: formatDbDate(inicio),
      TERMINO: formatDbDate(termino),
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
      numPeriodo: m[NUMPERIODO],
      inicio: parseDate(m[INICIO]),
      termino: parseDate(m[TERMINO]),
      presObrig: m[PRESOBRIG],
      medAprov: m[MEDAPROV],
      aulasDia: m[AULASDIA],
    );
  }

  @override
  String toString() {
    return "${this.id},${this.numPeriodo},${this.inicio},${this.termino},${this.presObrig},${this.medAprov},${this.materias},${this.aulasDia}";
  }

  addHorario(Horarios horario){
    horarios.add(horario);
  }

  setCalendario(List<Pair<int, List<DateTime>>> calendario){
    calendario = calendario;
  }
}
