import 'package:curso/database/base_table.dart';

class Aulas implements BaseTable {
  Aulas({
    this.id,
    this.idPeriodo,
    this.idMateria,
    this.weekDay,
    this.ordem,
  });

  factory Aulas.fromMap(Map m) {
    return Aulas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      idPeriodo: m[IDPERIODO],
      weekDay: m[WEEKDAY],
      ordem: m[ORDEM],
    );
  }
  
  int id, idPeriodo, idMateria, weekDay, ordem;

  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String IDPERIODO = "id_periodo";
  static const String WEEKDAY = "week_day";
  static const String ORDEM = "ordem";

  static List<String> provideColumns = [
    ID,
    IDMATERIA,
    IDPERIODO,
    WEEKDAY,
    ORDEM,
  ];

  static String tableName = "aulas";

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      IDPERIODO: idPeriodo,
      IDMATERIA: idMateria,
      WEEKDAY: weekDay,
      ORDEM: ordem,
    };

    if (id != null) {
      m[ID] = id;
    }
    return m;
  }

  static String getCreateSQL() {
    return """
      CREATE TABLE $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDPERIODO INTEGER NOT NULL,
      $IDMATERIA INTEGER NOT NULL,
      $WEEKDAY INTEGER NOT NULL DEFAULT 0,
      $ORDEM INTEGER NOT NULL
      );
    """;
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, idMateria: $idMateria, weekDay: $weekDay, ordem: $ordem";
  }
}
