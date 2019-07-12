import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';

class Horarios implements BaseTable {
  int id, idPeriodo, ordemAula;
  DateTime inicio, termino;

  Horarios({
    @required this.idPeriodo,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
    this.id,
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
      IDPERIODO: idPeriodo,
      ORDEMAULA: ordemAula,
      INICIO: formatTime(inicio),
      TERMINO: formatTime(termino),
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  factory Horarios.fromMap(Map m) {
    return Horarios(
      id: m[ID],
      idPeriodo: m[IDPERIODO],
      ordemAula: m[ORDEMAULA],
      inicio: parseTime(m[INICIO]),
      termino: parseTime(m[TERMINO]),
    );
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, ordemAula: $ordemAula, inicio: ${formatTime(inicio)}, termino: ${formatTime(termino)}";
  }

  Horarios getCopy() {
    return Horarios(
      id: id,
      idPeriodo: idPeriodo,
      inicio: inicio,
      termino: termino,
      ordemAula: ordemAula,
    );
  }
}
