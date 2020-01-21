import 'package:curso/utils.dart/random_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'configurations_dto.g.dart';

@JsonSerializable(nullable: true)
class ConfigurationsDto {
  ConfigurationsDto();

  factory ConfigurationsDto.fromJson(Map<String, dynamic> json) {
    return _$ConfigurationsDtoFromJson(json);
  }

  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  bool isLight;

  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  bool notify;

  Map<String, dynamic> toJson() => _$ConfigurationsDtoToJson(this);
}
