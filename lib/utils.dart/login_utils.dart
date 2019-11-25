import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';

class LoginUtils {
  static String validaEmail(String s) {
    if (!StringUtils.isValidEmail(s)) {
      return Errors.emailInvalido;
    } else {
      return null;
    }
  }

  static String validaSenha(String s) {
    if (s.length < 6) {
      return Errors.senhaPoucosCaracteres;
    } else if (!StringUtils.isValidPassword(s)) {
      return Errors.senhaInvalida;
    } else {
      return null;
    }
  }

  static String isSamePassword(String password, String retypedPassword) {
    if(password != retypedPassword) {
      return Errors.senhasNaoCoincidem;
    } else {
      return null;
    }
  }
}