import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class Faltas implements BaseTable {
  Faltas({
    @required this.id,
    @required this.idMateria,
    @required this.data,
    @required this.numAula,
    @required this.tipo,
  });

  factory Faltas.fromMap(Map m) {
    return Faltas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      data: parseDate(m[DATA]),
      numAula: m[NUMAULA],
      tipo: m[TIPO],
    );
  }

  int id;
  int idMateria;
  DateTime data;
  int numAula;

  ///Tipo pode ser 0 - Falta ou 1 - Aula Vaga
  int tipo;

  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String DATA = "dt";
  static const String NUMAULA = "num_aula";
  static const String TIPO = "tipo";

  static List<String> provideColumns = [ID, IDMATERIA, DATA, NUMAULA, TIPO];

  static String tableName = "faltas";

  static String getCreateSQL() {
    return """
      create table $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDMATERIA INTEGER NOT NULL,
      $DATA TEXT,
      $NUMAULA INTEGER,
      $TIPO INTEGER
    );
    """;
  }

  @override
  Map toMap() {
    final Map<String, Object> m = {
      IDMATERIA: idMateria,
      DATA: formatDbDate(data),
      NUMAULA: numAula,
      TIPO: tipo,
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "id: $id, idMateria: $idMateria, data: ${formatDate(data)}, numAula: $numAula, tipo: $tipo";
  }
}
