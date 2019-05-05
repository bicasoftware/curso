import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/double_utils.dart';

class ViewProvasListItemMaterias extends StatelessWidget {
  final List<MateriasByDate> materias;
  final Function(Notas) onTap;

  const ViewProvasListItemMaterias({
    Key key,
    @required this.materias,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: materias.length,
      itemBuilder: (_, i) {
        final m = materias[i];
        return InkWell(
          onTap: () {
            ///mostrar dialog de notas
          },
          child: Container(
            padding: EdgeInsets.all(4),
            child: ListTile(
              dense: true,
              onTap: () => onTap(m.notas),
              leading: Icon(Icons.school, color: Color(m.cor)),
              title: Text(m.nome),
              trailing: Text((formatNota(m.notas.nota ?? 0.0))),
            ),
          ),
        );
      },
    );
  }
}
