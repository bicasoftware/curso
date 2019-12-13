import 'package:curso/database/base_table.dart';
import 'package:curso/models/aulas.dart';
import 'package:curso/models/faltas.dart';
import 'package:curso/models/notas.dart';
import 'package:curso/utils.dart/random_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class Materias implements BaseTable {
  Materias({
    this.id,
    this.idPeriodo,
    this.nome,
    this.sigla,
    this.freq,
    this.medaprov,
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
      medaprov: m[MEDAPROV],
      freq: m[FREQ] == 1,
      cor: m[COR],
    );
  }

  factory Materias.fromJson(Map<String, dynamic> json) {
    final aulas = <Aulas>[];
    final notas = <Notas>[];
    final faltas = <Faltas>[];

    if (json['aulas'] != null) {
      json['aulas'].forEach((v) => aulas.add(Aulas.fromJson(v)));
    }
    if (json['faltas'] != null) {
      json['faltas'].forEach((v) => faltas.add(Faltas.fromJson(v)));
    }
    if (json['notas'] != null) {
      json['notas'].forEach((v) => notas.add(Notas.fromJson(v)));
    }
    return Materias(
      id: json['id'],
      cor: int.tryParse(json['cor']) ?? Colors.indigo,
      nome: json['nome'],
      sigla: json['sigla'],
      freq: json['freq'] == 1,
      medaprov: json['medaprov'] is int ? json['medaprov'].toDouble() : (json['medaprov'] as double),
    )
      ..notas = notas
      ..faltas = faltas
      ..aulas = aulas;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cor'] = cor;
    data['nome'] = nome;
    data['sigla'] = sigla;
    data['freq'] = freq;
    data['medaprov'] = medaprov;

    if (aulas != null) {
      data['aulas'] = this.aulas.map((v) => v.toJson()).toList();
    }
    if (faltas != null) {
      data['faltas'] = this.faltas.map((v) => v.toJson()).toList();
    }
    if (notas != null) {
      data['notas'] = this.notas.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int id, idPeriodo;
  String nome, sigla;
  @JsonKey(toJson: boolToInt, fromJson: intToBool)
  bool freq;
  double medaprov;
  @JsonKey(fromJson: int.tryParse)
  int cor;
  List<Faltas> faltas;
  List<Notas> notas;
  List<Aulas> aulas;

  static const String ID = "id";
  static const String IDPERIODO = "periodoId";
  static const String NOME = "nome";
  static const String SIGLA = "sigla";
  static const String FREQ = "freq";
  static const String MEDAPROV = "medaprov";
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
      MEDAPROV: medaprov,
      COR: cor,
    };

    if (id != null) {
      m[ID] = id;
    }

    return m;
  }

  @override
  String toString() {
    return "id: $id, idPeriodo: $idPeriodo, nome: $nome, sigla: $sigla,freq: $freq,medAprov: $medaprov,cor: $cor";
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
