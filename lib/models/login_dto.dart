import 'package:curso/models/periodos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable(nullable: true)
class DataDto {
  DataDto(this.periodos);

  factory DataDto.fromJson(Map<String, dynamic> json) => _$DataDtoFromJson(json);

  final List<Periodos> periodos;

  Map<String, dynamic> toJson() => _$DataDtoToJson(this);
}

@JsonSerializable(nullable: false)
class LoginDto {
  LoginDto({
    this.email,
    this.token,
    this.data,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);

  final String email, token;
  final DataDto data;

  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
