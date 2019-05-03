import 'package:curso/container/notas.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/widgets/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarioProvasDiaListTile extends StatelessWidget {
  final ProvasNotasMaterias provasNotasMaterias;
  final Function(Notas) onDeleted;
  final Function(Notas) onUpdateNota;

  const CalendarioProvasDiaListTile({
    Key key,
    @required this.provasNotasMaterias,
    @required this.onDeleted,
    @required this.onUpdateNota,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: HorarioAulaChip(
        color: Color(provasNotasMaterias.materia.cor),
        text: "Nota: ${formatNota(provasNotasMaterias.nota.nota)}",
        textColor: Colors.black54,
        iconColor: Colors.black87,
      ),
      title: Text(provasNotasMaterias.materia.nome),
      trailing: PopupMenuButton<int>(
        onSelected: (i) => _onItemSelected(context, i),
        itemBuilder: (c) => entryList(),
      ),
    );
  }

  void _onItemSelected(BuildContext context, int i) async {
    if (i == 0) {
      _confirmDelete(context);
    } else if (i == 1) {
      final double novaNota = await showNotaDialog(
        context: context,
        nota: provasNotasMaterias.nota.nota,
      );
      if (novaNota != null && novaNota != provasNotasMaterias.nota.nota) {
        onUpdateNota(provasNotasMaterias.nota..nota = novaNota);
      }
    }
  }

  List<PopupMenuEntry<int>> entryList() {
    return List<PopupMenuEntry<int>>()
      ..add(PopupMenuItem<int>(value: 0, child: Text(Strings.cancelarProva)))
      ..add(PopupMenuItem<int>(value: 1, child: Text(Strings.adicionarNota)));
  }

  void _confirmDelete(BuildContext context) async {
    final bool shouldDelete = await showConfirmationDialog(
      context: context,
      title: Strings.desagendarProva,
    );

    if (shouldDelete != null && shouldDelete) {
      onDeleted(provasNotasMaterias.nota);
    }
  }

  String formatNota(double nota) {
    return NumberFormat("##.## 00.00").format(nota ?? 0.0);
  }
}
