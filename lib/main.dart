import 'package:curso/app_entrance.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";
  runApp(AppEntrance());
}
