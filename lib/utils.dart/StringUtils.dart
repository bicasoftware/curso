class StringUtils {
  ///Gera sigla da matéria seguindo o padrão:
  ///apenas com mais de 3 caracteres,
  ///com 1 palavras apenas, retorna 3 primeiras letras em uppercase;
  ///com 2 palavras, tendo a segunda palavra sendo 2 número, retorna 3 letras e número
  ///com 2 palavras, retorna primeira letra em uppercase e tres primeiras letras da segunda palavra
  ///com 3 palavras ou mais, retorna a primeira letra de cada palavra;
  static String geraSigla(String str) {
    str = str.trim();
    if (str.length > 2) {
      final List<String> splitNome = str.split(" ")
        ..map((it) => it.trim())
        ..removeWhere((it) => it.length < 3 && !StringUtils.isInt(it));

      String nome;
      if (splitNome.length == 1) {
        nome = str.substring(0, 3).toUpperCase();
      } else if (splitNome.length == 2) {
        if (StringUtils.isInt(splitNome[1])) {
          nome = "${splitNome[0].substring(0, 3).toUpperCase()}${splitNome[1]}";
        } else {
          nome = "${splitNome[0][0].toUpperCase()}. ${toCammelCase(splitNome[1].substring(0, 3))}";
        }
      } else if (splitNome.length > 2) {
        nome = splitNome.map((it) => it[0]).join();
      }
      return nome;
    } else {
      return "";
    }
  }

  static String toCammelCase(String str) {
    return str
        .trim()
        .split(" ")
        .map((it) => "${it[0].toUpperCase()}${it.substring(1, it.length).toLowerCase()}")
        .join(" ");
  }

  static bool isInt(String str) {
    try {
      int.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isValidPassword(String pass) {
    return RegExp(r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,14}$').hasMatch(pass);
  }

  static bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    ).hasMatch(email);
  }
}
