import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_req_dto.g.dart';

@JsonSerializable(nullable: true)
class RefreshTokenRequest {
  RefreshTokenRequest();
  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) {
    return _$RefreshTokenRequestFromJson(json);
  }

  String refresh_token;

  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
