import 'package:curso/container/cronograma.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
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
      leading: CircleAvatar(
        child: Icon(Icons.school),
        backgroundColor: Color(provasNotasMaterias.materia.cor),
      ),
      title: Text(provasNotasMaterias.materia.nome),
      subtitle: Text("Nota: " + (provasNotasMaterias.nota.nota ?? 0.0).toString()),
      trailing: PopupMenuButton<int>(
        child: Icon(Icons.more_vert),
        itemBuilder: (_) {
          return <PopupMenuItem<int>>[
            PopupMenuItem<int>(child: const Text(Strings.adicionarNota), value: 0),
            PopupMenuItem<int>(child: const Text(Strings.cancelarProva), value: 1),
          ];
        },
        onSelected: (int action) {
          if (action != null) {
            if (action == 0) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("não implementado")));
            } else if (action == 1) {
              _confirmDelete(context);
            }
          }
        },
      ),
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
}
