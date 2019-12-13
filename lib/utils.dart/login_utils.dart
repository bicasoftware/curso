import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';

class LoginUtils {
  static String validaEmail(String s) {
    return !StringUtils.isValidEmail(s.trim()) ? Errors.emailInvalido : null;
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
    return password != retypedPassword ? Errors.senhasNaoCoincidem : null;
  }
}