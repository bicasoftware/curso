import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'horarios_dto.g.dart';

@JsonSerializable(nullable: true)
class HorariosDto {
  
  HorariosDto({
    @required this.periodo_id,
    @required this.ordemaula,
    @required this.inicio,
    @required this.termino,
    this.id,
  });

  factory HorariosDto.fromJson(Map<String, dynamic> json) {
    return _$HorariosDtoFromJson(json);
  }

  int id, periodo_id, ordemaula;
  String inicio, termino;

  Map<String, dynamic> toJson() => _$HorariosDtoToJson(this);
}
