import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'horarios_dto.dart';
import 'materias_dto.dart';
part 'periodos_dto.g.dart';

@JsonSerializable(nullable: true)
class PeriodosDto {
  PeriodosDto({
    @required this.numperiodo,
    @required this.aulasdia,
    @required this.presObrig,
    @required this.inicio,
    @required this.termino,
    @required this.medaprov,
    this.id,
  });

  factory PeriodosDto.fromJson(Map<String, dynamic> json) {
    return _$PeriodosDtoFromJson(json);
  }

  int id, numperiodo, aulasdia, presObrig;
  DateTime inicio, termino;
  double medaprov;

  List<MateriasDto> materias;
  List<HorariosDto> horarios;

  Map<String, dynamic> toJson() => _$PeriodosDtoToJson(this);
}
