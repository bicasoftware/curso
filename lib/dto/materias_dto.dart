import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'aulas_dto.dart';
import 'faltas_dto.dart';
import 'notas_dto.dart';
part 'materias_dto.g.dart';

@JsonSerializable(nullable: true)
class MateriasDto {
  MateriasDto({
    @required this.periodo_id,
    @required this.freq,
    @required this.cor,
    @required this.nome,
    @required this.sigla,
    @required this.medaprov,
    this.id,
  });
  factory MateriasDto.fromJson(Map<String, dynamic> json) {
    return _$MateriasDtoFromJson(json);
  }

  int id, periodo_id, freq;
  String cor, nome, sigla;
  double medaprov;

  List<AulasDto> aulas;
  List<FaltasDto> faltas;
  List<NotasDto> notas;

  Map<String, dynamic> toJson() => _$MateriasDtoToJson(this);
}
