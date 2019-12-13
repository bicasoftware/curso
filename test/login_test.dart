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
    final result = await LoginService.callLogin("saulo@test.com", "S17h05a8");
    if (result is LoginDto) {
      print("\n");
      print(result.configurations.toString());
      result.data.periodos.forEach((periodo) {
        print(periodo.toString());
        periodo.horarios.forEach((horario) => print(horario.toString()));
        print("\n");
        print("materias: ${periodo.materias.length}");
        periodo.materias.forEach((m) {
          print(m.toString());
          print("\n");
          m.faltas.forEach((falta) {
            print(falta.toString());
            print("\n");
          });
          m.aulas.forEach((aula) {
            print(aula.toString());
            print("\n");
          });
          m.notas.forEach((nota) {
            print(nota.toString());
            print("\n");
          });
        });
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

  test('unregister', () async {
    final result = await LoginService.callUnregister("teste1@gmail.com", "S17h05a8");
    if (result is ResponseError) {
      print(result.error);
    } else if (result == "ok") {
      print("conta removida");
    }
  });
}
