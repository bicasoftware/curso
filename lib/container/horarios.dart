import 'package:curso/database/base_table.dart';
import "package:curso/utils.dart/Formatting.dart";

class Horarios implements BaseTable {
  int id, idPeriodo, ordemAula;
  DateTime inicio, termino;

  Horarios({
    this.id,
    this.idPeriodo,
    this.ordemAula,
    this.inicio,
    this.termino,
  });

  static const String ID = "id";
  static const String IDPERIODO = "idperiodo";
  static const String ORDEMAULA = "ordem_aula";
  static const String INICIO = "inicio";
  static const String TERMINO = "termino";

  static const String tableName = "horarios";

  static List<String> provideColumns = [
    ID,
    IDPERIODO,
    ORDEMAULA,
    INICIO,
    TERMINO,
  ];

  static String getCreateSQL() {
    return """create table $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDPERIODO INTEGER NOT NULL,
      $ORDEMAULA INTEGER NOT NULL DEFAULT "",
      $INICIO TEXT NOT NULL,
      $TERMINO TEXT NOT NULL
    );""";
  }

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      IDPERIODO: this.idPeriodo,
      ORDEMAULA: this.ordemAula,
      INICIO: Formatting.formatTime(this.inicio),
      TERMINO: Formatting.formatTime(this.termino),
    };

    if (id != null) m[ID] = id;

    return m;
  }

  static Horarios fromMap(Map m) {
    return Horarios(
      id: m[ID],
      idPeriodo: m[IDPERIODO],
      ordemAula: m[ORDEMAULA],
      inicio: m[INICIO],
      termino: m[TERMINO],
    );
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, ordemAula: $ordemAula, inicio: ${Formatting.formatTime(this.inicio)}, termino: ${Formatting.formatTime(this.termino)}";
  }
}
