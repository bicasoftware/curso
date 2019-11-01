import 'package:curso/container/calendario.dart';
import 'package:curso/models/periodos.dart';
import 'package:curso/widgets/bottom_sheets/bottomsheet_aulas_dia.dart';
import 'package:curso/widgets/bottom_sheets/bottomsheet_materias.dart';
import 'package:flutter/material.dart';

class BottomSheets {
  static Future<int> showBtsMaterias(
    BuildContext context,
    Periodos periodo,
  ) async {
    return showModalBottomSheet(
      context: context,
      builder: (c) {
        return BottomSheetMaterias(
          materias: periodo.materias,
        );
      },
    );
  }

  static Future<int> showBtsProvasDia(
    BuildContext context,
    List<AulasSemanaDTO> aulasSemana,
  ) async {
    return showModalBottomSheet(
      context: context,
      builder: (c) {
        return BottomSheetAulasDia(aulasSemana: aulasSemana);
      },
    );
  }
}
