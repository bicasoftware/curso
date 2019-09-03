import 'package:curso/app_entrance.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

  final prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey(Keys.app_brightness)) {
    ///[0] = [light]
    ///[1] = [dark]
    await prefs.setInt(Keys.app_brightness, 1);
  }
  runApp(
    AppEntrance(
      periodos: await ProviderPeriodos.fetchAllPeriodos(),
      brightness: prefs.getInt(Keys.app_brightness),
    ),
  );
}
