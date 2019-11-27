import 'package:curso/models/login_dto.dart';
import 'package:curso/services/login_service.dart';
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
    final result = await LoginService.callLogin("saulo@test.com", "97674691");
    if (result is LoginDto) {
      result.data.periodos.forEach((periodo) {
        print("numero periodo${periodo.numPeriodo}");
        periodo.horarios.forEach((horario) => print(horario.inicio));
      });
    }
  });
}
