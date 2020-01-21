import 'package:curso/dto/auth_dto.dart';
import 'package:curso/dto/refresh_token_dto.dart';
import 'package:curso/dto/refresh_token_req_dto.dart';
import 'package:curso/dto/unregister_dto.dart';
import 'package:curso/dto/user_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:curso/stuff.dart';

part 'client_auth.g.dart';

@RestApi(baseUrl: '${host}/auth')
abstract class ClientAuth {
  factory ClientAuth(Dio dio) = _ClientAuth;

  @POST('/authenticate')
  Future<AuthDto> authenticate(@Body() UserDto user);

  @POST('/register')
  Future<AuthDto> register(@Body() UserDto user);

  @POST('/unregister')
  Future<UnregisterDto> unregister();

  @POST('/refresh')
  Future<RefreshTokenDto> refreshToken(@Body() RefreshTokenRequest request);
}
