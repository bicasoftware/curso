import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'faltas.g.dart';

@JsonSerializable(nullable: true)
class Faltas implements BaseTable {
  Faltas({
    @required this.id,
    @required this.idMateria,
    @required this.data,
    @required this.ordemAula,
    @required this.tipo,
  });

  factory Faltas.fromMap(Map m) {
    return Faltas(
      id: m[ID],
      idMateria: m[IDMATERIA],
      data: parseDate(m[DATA]),
      ordemAula: m[NUMAULA],
      tipo: m[TIPO],
    );
  }

  factory Faltas.fromJson(Map<String, dynamic> json) => _$FaltasFromJson(json);

  Map<String, dynamic> toJson() => _$FaltasToJson(this);

  int id;
  int idMateria;
  DateTime data;
  int ordemAula;

  ///Tipo pode ser 0 - Falta ou 1 - Aula Vaga
  int tipo;

  static const String ID = "id";
  static const String IDMATERIA = "materiaId";
  static const String DATA = "data";
  static const String NUMAULA = "ordemAula";
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
      NUMAULA: ordemAula,
      TIPO: tipo,
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "id: $id, idMateria: $idMateria, data: ${formatDate(data)}, numAula: $ordemAula, tipo: $tipo";
  }
}
