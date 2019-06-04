import 'package:curso/container/materias.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class PickerMaterias extends StatelessWidget {
  final List<Materias> materias;
  final Function(int) onTap;

  const PickerMaterias({
    @required this.materias,
    @required this.onTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: materias.length,
      itemBuilder: (c, i) {
        final m = materias[i];
        return ListTile(
          onTap: () => onTap(materias[i].id),
          leading: MateriaColorContainer(color: Color(m.cor), type: MaterialType.circle),
          title: Text(m.nome),
          subtitle: Text(m.sigla),
        );
      },
    );
  }
}
