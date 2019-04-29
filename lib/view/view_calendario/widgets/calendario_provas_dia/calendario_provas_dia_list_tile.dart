import 'package:curso/container/cronograma.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/widgets/horario_aula_tile_chip.dart';
import 'package:flutter/material.dart';

class CalendarioProvasDiaListTile extends StatelessWidget {
  final ProvasNotasMaterias provasNotasMaterias;
  final Function(Notas) onDeleted;

  const CalendarioProvasDiaListTile({
    Key key,
    @required this.provasNotasMaterias,
    @required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => _onLongPress(context),
      leading: HorarioAulaChip(
        color: Color(provasNotasMaterias.materia.cor),
        text: "Nota: " + (provasNotasMaterias.nota.nota ?? 0.0).toString(),
      ),

      // leading: CircleAvatar(
      //   child: Icon(Icons.school, color: Colors.black),
      //   backgroundColor: Color(provasNotasMaterias.materia.cor),
      // ),
      title: Text(provasNotasMaterias.materia.nome),
      subtitle: Text("Nota: " + (provasNotasMaterias.nota.nota ?? 0.0).toString()),
    );
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

  void _onLongPress(BuildContext context) async {
    int action = await showOptionsDialog(context: context, title: Strings.opcoes, options: [
      Strings.adicionarNota,
      Strings.cancelarProva,
    ]);

    if (action == 0) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("não implementado")));
    } else if (action == 1) {
      _confirmDelete(context);
    }
  }
}
