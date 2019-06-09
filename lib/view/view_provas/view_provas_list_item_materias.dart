import 'package:curso/container/falta_container.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/widgets/materia_color_container.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final m in materias)
          InkWell(
            onTap: () => onTap(m.notas),
            child: ListTile(
              dense: true,
              leading: MateriaColorContainer(color: Color(m.cor), size: 24),
              title: Text(m.nome),
              trailing: Text((formatNota(m.notas.nota ?? 0.0))),
            ),
          )
      ],
    );
  }
}
