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
}