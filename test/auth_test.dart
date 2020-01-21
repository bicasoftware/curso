import 'package:curso/clients/client_auth.dart';
import 'package:curso/clients/client_helper.dart';
import 'package:curso/dto/auth_dto.dart';
import 'package:curso/dto/refresh_token_dto.dart';
import 'package:curso/dto/refresh_token_req_dto.dart';
import 'package:curso/dto/unregister_dto.dart';
import 'package:curso/dto/user_dto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ClientAuth(ClientHelper().getDio());
  String token, refreshToken;

  test('register', () async {
    final UserDto user = UserDto()
      ..email = "saulo@test.com"
      ..password = 'S17h05a8'
      ..username = "Saulo Andrioli";

    try {
      final result = await client.register(user);
      assert(result is AuthDto);
      token = result.token;
      refreshToken = result.refresh_token;

      print(token);
    } catch (e) {
      if (e is DioError) {
        print(e.response);
      }
    }
  });

  test('authenticate', () async {
    final UserDto user = UserDto()
      ..email = "saulo@test.com"
      ..password = 'S17h05a8'
      ..username = "Saulo Andrioli";

    final result = await client.authenticate(user);

    print(result.periodos.length);
    print(result.token);
    print(result.refresh_token);

    assert(result is AuthDto);
    assert(result.email.isNotEmpty);
    token = result.token;
    refreshToken = result.refresh_token;
  });

  test('refresh token', () async {
    try {
      final result = await client.refreshToken(
        RefreshTokenRequest()..refresh_token = refreshToken,
      );

      assert( result is RefreshTokenDto);
    } catch (e) {
      if (e is DioError) {
        print(e.response);
      }
    }
  });

  test('unregister', () async {
    final otherDio = Dio();
    otherDio.options.headers['Authorization'] = "Bearer $token";
    final unregisterClient = ClientAuth(otherDio);
    final result = await unregisterClient.unregister();

    assert(result is UnregisterDto);
    assert(result.removed == true);
  });
}
