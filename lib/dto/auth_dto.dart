import 'package:json_annotation/json_annotation.dart';

import 'configurations_dto.dart';
import 'periodos_dto.dart';

part 'auth_dto.g.dart';

@JsonSerializable(nullable: true)
class AuthDto {
  AuthDto();

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return _$AuthDtoFromJson(json);
  }

  List<PeriodosDto> periodos;
  ConfigurationsDto configurations;
  String email, token, refresh_token;

  Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}
