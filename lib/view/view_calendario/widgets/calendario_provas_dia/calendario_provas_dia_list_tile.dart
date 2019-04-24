import 'package:curso/container/cronograma.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/dialogs.dart';

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
      trailing: IconButton(
        icon: Icon(Icons.delete_sweep),
        onPressed: () async {
          final bool shouldDelete = await showConfirmationDialog(
            context: context,
            title: Strings.desagendarProva,
          );

          if (shouldDelete != null && shouldDelete) {
            onDeleted(provasNotasMaterias.nota);
          }
        },
      ),
    );
  }
}
