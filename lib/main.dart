import 'package:curso/app_entrance.dart';
import 'package:curso/providers/provider_faltas.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

  // await ProviderFaltas.truncate();

  /* await ProviderFaltas.fetchAll()
    ..forEach((f) => print(f)); */

  runApp(
    AppEntrance(
      periodos: await ProviderPeriodos.fetchAllPeriodos(),
    ),
  );
}
