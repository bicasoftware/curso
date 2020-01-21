import 'package:json_annotation/json_annotation.dart';
part 'notas_dto.g.dart';

@JsonSerializable(nullable: true)
class NotasDto {
  NotasDto();
  factory NotasDto.fromJson(Map<String, dynamic> json) {
    return _$NotasDtoFromJson(json);
  }

  int id, materia_id;
  DateTime data;
  double nota;

  Map<String, dynamic> toJson() => _$NotasDtoToJson(this);
}
