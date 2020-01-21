import 'package:json_annotation/json_annotation.dart';

part 'faltas_dto.g.dart';

@JsonSerializable(nullable: true)
class FaltasDto {

  FaltasDto({
    this.id,
    this.materia_id,
    this.ordemAula,
    this.data,
  });

  factory FaltasDto.fromJson(Map<String, dynamic> json) {
    return _$FaltasDtoFromJson(json);
  }

  int id, materia_id, ordemAula;
  DateTime data;

  Map<String, dynamic> toJson() => _$FaltasDtoToJson(this);
}
