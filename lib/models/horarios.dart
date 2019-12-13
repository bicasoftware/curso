import 'package:curso/database/base_table.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'horarios.g.dart';

@JsonSerializable(nullable: true)
class Horarios implements BaseTable {
  Horarios({
    @required this.idPeriodo,
    @required this.ordemaula,
    @required this.inicio,
    @required this.termino,
    this.id,
  });

  factory Horarios.fromMap(Map m) {
    return Horarios(
      id: m[ID],
      idPeriodo: m[IDPERIODO],
      ordemaula: m[ORDEMAULA],
      inicio: parseTime(m[INICIO]),
      termino: parseTime(m[TERMINO]),
    );
  }

  factory Horarios.fromJson(Map<String, dynamic> json) => _$HorariosFromJson(json);

  Map<String, dynamic> toJson() => _$HorariosToJson(this);

  int id, idPeriodo, ordemaula;

  @JsonKey(fromJson: parseTime, toJson: formatTime)
  DateTime inicio, termino;

  static const String ID = "id";
  static const String IDPERIODO = "periodoId";
  static const String ORDEMAULA = "ordemaula";
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
      ORDEMAULA: ordemaula,
      INICIO: formatTime(inicio),
      TERMINO: formatTime(termino),
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, ordemAula: $ordemaula, inicio: ${formatTime(inicio)}, termino: ${formatTime(termino)}";
  }

  Horarios getCopy() {
    return Horarios(
      id: id,
      idPeriodo: idPeriodo,
      inicio: inicio,
      termino: termino,
      ordemaula: ordemaula,
    );
  }
}
