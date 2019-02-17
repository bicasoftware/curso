import 'package:curso/database/base_table.dart';

class Aulas implements BaseTable {
  int id, idMateria, weekDay, ordem;

  Aulas({
    this.id,
    this.idMateria,
    this.weekDay,
    this.ordem,
  });

  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String WEEKDAY = "week_day";
  static const String ORDEM = "ordem";

  // Aulas copyWith({int id, int idMateria, int weekDay, int ordem}) {
  //   return Aulas(
  //     id: id ?? this.id,
  //     idMateria: idMateria ?? this.idMateria,
  //     ordem: ordem ?? this.ordem,
  //     weekDay: weekDay ?? this.weekDay,
  //   );
  // }

  static List<String> provideColumns = [
    ID,
    IDMATERIA,
    WEEKDAY,
    ORDEM,
  ];

  static String tableName = "aulas";

  static Aulas fromMap(Map m) {
    return Aulas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      weekDay: m[WEEKDAY],
      ordem: m[ORDEM],
    );
  }

  @override
  Map toMap() {
    Map<String, dynamic> m = {
      IDMATERIA: idMateria,
      WEEKDAY: weekDay,
      ORDEM: ordem,
    };

    if (id != null) m[ID] = id;
    return m;
  }

  static String getCreateSQL() {
    return """
      CREATE TABLE $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDMATERIA INTEGER NOT NULL,
      $WEEKDAY INTEGER NOT NULL DEFAULT 0,
      $ORDEM INTEGER NOT NULL
      );
    """;
  }

  @override
  String toString(){
    return "id: $id, idMateria: $idMateria, weekDay: $weekDay, ordem: $ordem";
  }
}
