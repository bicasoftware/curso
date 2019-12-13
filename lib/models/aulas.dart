import 'package:curso/database/base_table.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aulas.g.dart';

@JsonSerializable(nullable: true)
class Aulas implements BaseTable {
  Aulas({
    this.id,
    this.idPeriodo,
    this.idMateria,
    this.weekday,
    this.ordem,
  });

  factory Aulas.fromMap(Map m) {
    return Aulas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      idPeriodo: m[IDPERIODO],
      weekday: m[WEEKDAY],
      ordem: m[ORDEM],
    );
  }

  factory Aulas.fromJson(Map<String, dynamic> json) => _$AulasFromJson(json);

  Map<String, dynamic> toJson() => _$AulasToJson(this);

  int id, idPeriodo, idMateria, weekday, ordem;

  static const String ID = "id";
  static const String IDMATERIA = "materiaId";
  static const String IDPERIODO = "id_periodo";
  static const String WEEKDAY = "weekday";
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
      WEEKDAY: weekday,
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
    return "id: $id, idPeriodo: $idPeriodo, idMateria: $idMateria, weekDay: $weekday, ordem: $ordem";
  }
}
