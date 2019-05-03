import 'package:curso/container/falta_container.dart';
import 'package:flutter/material.dart';

class ViewProvasListItemMaterias extends StatelessWidget {
  final List<MateriasByDate> materias;

  const ViewProvasListItemMaterias({Key key, this.materias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: materias.length,
      itemBuilder: (_, i) {
        final m = materias[i];
        return InkWell(
          onTap: (){
            ///mostrar dialog de notas
          },
          child: Container(
            padding: EdgeInsets.all(4),
            child: ListTile(
              dense: true,
              leading: Icon(Icons.school, color: Color(m.cor)),
              title: Text(m.nome),
              trailing: Text((m.notas.nota ?? 0.0).toString()),
            ),
          ),
        );
      },
    );
  }
}
