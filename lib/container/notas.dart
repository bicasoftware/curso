import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/Formatting.dart';

class Notas implements BaseTable {
  final int id, idMateria;
  final DateTime data;
  final double nota;

  Notas({
    this.id,
    this.idMateria,
    this.data,
    this.nota,
  });

  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String DATA = "dt_prova";
  static const String NOTA = "nota";

  Notas copyWith({int id, int idMateria, DateTime data, int ordemAula}) {
    return Notas(
      id: id ?? this.id,
      idMateria: idMateria ?? this.idMateria,
      data: data ?? this.data,
      nota: ordemAula ?? this.nota,
    );
  }


  static List<String> provideColumns = [ID, IDMATERIA, DATA, NOTA];

  static String getCreateSQL() {
    return """create table $tableName(
        $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        $IDMATERIA INTEGER NOT NULL,
        $DATA TEXT,
        $NOTA INTEGER
      );""";
  }

  @override
  Map toMap() {
    Map<String, dynamic> m = {
      IDMATERIA: idMateria,
      DATA: Formatting.formatDate(data),
      NOTA: nota,
    };

    if(id != null) m[ID] = id;

    return m;
  }


  static String tableName = "notas";

  static Notas fromMap(Map m){
    return Notas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      data: Formatting.parseDate(m[DATA]),
      nota: m[NOTA],
    );
  }
}
