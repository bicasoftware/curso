import 'package:json_annotation/json_annotation.dart';
part 'unregister_dto.g.dart';

@JsonSerializable(nullable: false)
class UnregisterDto {
  UnregisterDto();
  factory UnregisterDto.fromJson(Map<String, dynamic> json) {
    return _$UnregisterDtoFromJson(json);
  }

  bool removed;

  Map<String, dynamic> toJson() => _$UnregisterDtoToJson(this);
}