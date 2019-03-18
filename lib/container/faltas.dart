import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';

class Faltas implements BaseTable {
  int id;
  int idMateria;
  DateTime data;
  int numAula;

  Faltas({
    this.id,
    this.idMateria,
    this.data,
    this.numAula,
  });

  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String DATA = "dt";
  static const String NUMAULA = "num_aula";

  static List<String> provideColumns = [ID, IDMATERIA, DATA, NUMAULA];

  static String tableName = "faltas";

  static String getCreateSQL() {
    return """
      create table $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDMATERIA INTEGER NOT NULL,
      $DATA TEXT,
      $NUMAULA INTEGER
    );
    """;
  }

  @override
  Map toMap() {
    final Map<String, Object> m = {
      IDMATERIA: idMateria,
      DATA: data,
      NUMAULA: numAula,
    };

    if (id != null) m[ID] = id;

    return m;
  }

  static Faltas fromMap(Map m) {
    return Faltas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      data: parseDate(m[DATA]),
      numAula: m[NUMAULA],
    );
  }
}
