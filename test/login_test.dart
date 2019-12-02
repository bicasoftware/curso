import 'package:curso/models/login_dto.dart';
import 'package:curso/services/login_service.dart';
import 'package:curso/services/response_error.dart';
import 'package:curso/utils.dart/StringUtils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('login_test', () {
    assert("oi" == "oi");
  });

  test('password', () {
    const pass = "S17h05a8";
    assert(StringUtils.isValidPassword(pass));
  });

  test('email', () {
    const email = "saulo@teste.com";
    assert(StringUtils.isValidEmail(email));
  });

  test('login', () async {
    final result = await LoginService.callLogin("teste1@gmail.com", "S17h05a8");
    if (result is LoginDto) {
      result.data.periodos.forEach((periodo) {
        print("numero periodo${periodo.numPeriodo}");
        periodo.horarios.forEach((horario) => print(horario.inicio));
      });
    }
  });

  test('cadastro', () async {
    final result = await LoginService.callCadastro("teste1@gmail.com", "S17h05a8");
    if (result is Map) {
      print(result['email']);
      print(result['token']);
    } else if (result is ResponseError) {
      print(result.error);
      print(result.statusCode);
    }
  });

  //TODO - Testar servidor, rotina de unregister!!!!
  test('unregister', () async {
    final result = await LoginService.callUnregister("saulo5@test.com", "S17h05a8");
    if (result is ResponseError) {
      print(result.error);
    } else if (result == "ok") {
      print("conta removida");
    }
  });
}
