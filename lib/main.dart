import 'package:curso/app_entrance.dart';
import 'package:curso/providers/provider_configuration.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

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
