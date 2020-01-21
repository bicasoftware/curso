import 'package:json_annotation/json_annotation.dart';

part 'aulas_dto.g.dart';

@JsonSerializable(nullable: true)
class AulasDto {
  AulasDto();

  factory AulasDto.fromJson(Map<String, dynamic> json) {
    return _$AulasDtoFromJson(json);
  }

  int id, materia_id, weekday, ordem;

  Map<String, dynamic> toJson() => _$AulasDtoToJson(this);
}
