import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:flutter/material.dart';

class ParcialHeader extends StatelessWidget {
  final String materia, sigla;
  final int cor;
  final ParciaisStatus status;

  const ParcialHeader({
    @required this.materia,
    @required this.sigla,
    @required this.cor,
    @required this.status,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: MateriaColorContainer(color: Color(cor)),
      title: Text(materia),
      subtitle: Text(
        status.title,
        style: Theme.of(context).textTheme.subtitle.copyWith(color: status.cor),
      ),
      trailing: status.icon,
    );
  }
}
