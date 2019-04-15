import 'package:curso/widgets/rounded_bottomsheet_container.dart';
import 'package:flutter/material.dart';

import '../container/periodos.dart';
import '../widgets/bottomsheet_materias.dart';

class BottomSheets {
  static Future<int> showBtsMaterias(
    BuildContext context,
    Periodos periodo,
  ) async {
    return showModalBottomSheet(      
      context: context,
      builder: (c) => RoundedBottomSheetContainer(child: BottomSheetMaterias(materias: periodo.materias)),
    );
  }
}
