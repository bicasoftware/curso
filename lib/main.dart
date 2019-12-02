import 'package:curso/home_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

  runApp(
    ViewCheckState(),
  );
}
/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

  //TODO - Remover dados e remover parametros para AppEntrance()
  //TODO - Remover AppEntrance e utilizar MyApp()
  //TODO - Renomear MyApp com outro nome

  final dados = await Future.wait([
    ProviderPeriodos.fetchAllPeriodos(),
    ProviderConfiguration.fetchBrightness(),
  ]);

  runApp(
    AppEntrance(
      periodos: dados[0],
      isLight: dados[1],
    ),
  );
}
*/
