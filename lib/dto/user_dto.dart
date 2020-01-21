import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable(nullable: true)
class UserDto {
  UserDto();
  factory UserDto.fromJson(Map<String, dynamic> json) {
    return _$UserDtoFromJson(json);
  }

  String email, password, username;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}