import 'package:curso/database/base_table.dart';
import 'package:curso/models/aulas.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/random_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'materias.g.dart';

@JsonSerializable(nullable: true)
class Materias implements BaseTable {
  Materias({
    this.id,
    this.idPeriodo,
    this.nome,
    this.sigla,
    this.freq,
    this.medAprov,
    this.cor,
    this.faltas,
    this.notas,
    this.aulas,
  }) {
    faltas = [];
    notas = [];
    aulas = [];
  }

  factory Materias.fromMap(Map m) {
    return Materias(
      id: m[ID],
      idPeriodo: m[IDPERIODO],
      nome: m[NOME],
      sigla: m[SIGLA],
      medAprov: m[MEDAPROV],
      freq: m[FREQ] == 1,
      cor: m[COR],
    );
  }

  factory Materias.fromJson(Map<String, dynamic> json) => _$MateriasFromJson(json);

  Map<String, dynamic> toJson() => _$MateriasToJson(this);

  int id, idPeriodo;
  String nome, sigla;
  @JsonKey(toJson: boolToInt, fromJson: intToBool)
  bool freq;
  double medAprov;
  @JsonKey(fromJson: strToInt)
  int cor;
  List<Faltas> faltas;
  List<Notas> notas;
  List<Aulas> aulas;

  static const String ID = "id";
  static const String IDPERIODO = "id_periodo";
  static const String NOME = "nome";
  static const String SIGLA = "sigla";
  static const String FREQ = "freq";
  static const String MEDAPROV = "med_aprov";
  static const String COR = "cor";

  static List<String> provideColumns = [
    ID,
    IDPERIODO,
    NOME,
    SIGLA,
    FREQ,
    MEDAPROV,
    COR,
  ];

  static String tableName = "materias";

  static String getCreateSQL() {
    return """create table $tableName(
      $ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      $IDPERIODO INTEGER NOT NULL,
      $NOME text NOT NULL DEFAULT "",
      $SIGLA text NOT NULL DEFAULT "",
      $FREQ INTEGER NOT NULL DEFAULT 1,
      $MEDAPROV REAL NOT NULL DEFAULT 5.0,
      $COR INTEGER
    );""";
  }

  @override
  Map toMap() {
    final Map<String, dynamic> m = {
      IDPERIODO: idPeriodo,
      NOME: nome,
      SIGLA: sigla,
      FREQ: freq,
      MEDAPROV: medAprov,
      COR: cor,
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, nome: $nome, sigla: $sigla,freq: $freq,medAprov: $medAprov,cor: $cor";
  }

  Materias clone() {
    return Materias(
      id: id,
      idPeriodo: idPeriodo,
      nome: nome,
      sigla: sigla,
      cor: cor,
    );
  }

  void insertFalta(Faltas falta) {
    faltas.add(falta);
  }

  void deleteFalta(int idFalta) {
    faltas.removeWhere((f) => f.id == idFalta);
  }

  void insertNota(Notas nota) {
    notas.add(nota);
  }

  void deleteNota(Notas nota) {
    notas.remove(nota);
  }

  void updateNota(Notas nota) {
    notas.firstWhere((n) => n.id == nota.id).updateNota(nota.nota);
  }
}
