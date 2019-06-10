import 'package:curso/container/notas.dart';
import 'package:curso/container/provas_notas_materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

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
      leading: MateriaColorContainer(
        color: Color(provasNotasMaterias.materia.cor),
        size: 32,
      ),
      title: Text(provasNotasMaterias.materia.nome),
      subtitle: Text("Nota: ${formatNota(provasNotasMaterias.nota.nota)}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.amber),
            onPressed: () => _showUpdateNotaDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.delete_sweep, color: Colors.red),
            onPressed: () => _confirmDelete(context),
          )
        ],
      ),      
    );
    /* return ListTile(
      dense: true,
      leading: HorarioAulaChip(
        color: Color(provasNotasMaterias.materia.cor),
        text: "Nota: ${formatNota(provasNotasMaterias.nota.nota)}",
      ),
      title: Text(provasNotasMaterias.materia.nome),
      trailing: PopupMenuButton<int>(
        onSelected: (i) => _onItemSelected(context, i),
        itemBuilder: (c) => entryList(),
      ),
    ); */
  }

  void _showUpdateNotaDialog(BuildContext context) async {
    final double novaNota = await showNotaDialog(
      context: context,
      nota: provasNotasMaterias.nota.nota,
    );
    if (novaNota != null && novaNota != provasNotasMaterias.nota.nota) {
      onUpdateNota(provasNotasMaterias.nota..nota = novaNota);
    }
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
  /* void _onItemSelected(BuildContext context, int i) async {
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
  } */

}
