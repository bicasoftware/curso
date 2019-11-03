import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';

class Notas implements BaseTable {
  Notas({
    this.id,
    this.idMateria,
    this.data,
    this.nota,
  });
  
  factory Notas.fromMap(Map m) {
    return Notas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      data: parseDate(m[DATA]),
      nota: double.tryParse(m[NOTA].toString()),
    );
  }

  int id, idMateria;
  DateTime data;
  double nota;
  
  static const String ID = "id";
  static const String IDMATERIA = "id_materia";
  static const String DATA = "dt_prova";
  static const String NOTA = "nota";

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
    final Map<String, dynamic> m = {
      IDMATERIA: idMateria,
      DATA: formatDbDate(data),
      NOTA: nota,
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  static String tableName = "notas";

  @override
  String toString() {
    return "id: $id, idMateria: $idMateria, data: $data, nota: $nota";
  }

  void updateNota(double novaNota) => nota = novaNota;
}