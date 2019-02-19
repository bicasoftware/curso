import 'package:curso/app_entrance.dart';
import 'package:curso/providers/provider_conf.dart';
import 'package:curso/providers/provider_periodos.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

//todo - Adicionar DropDownButton para selecionar o número do Período
// adicionar a list no bottomsheet de materia, uma opção para remover as aulas
// adicionar a opção de atualizar a materia usando o bottomsheet de materias

void main() async {
  initializeDateFormatting("pt_BR", null);
  Intl.defaultLocale = "pt_BR";

  Future.wait([
    ProviderPeriodos.fetchAllPeriodos(),
    ProviderConf.fetchConf(),
  ]).then((List<Object> it) {
    runApp(
      AppEntrance(
        periodos: it[0],
        conf: it[1],
      ),
    );
  }).catchError((e) => print(e));
}
