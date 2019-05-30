import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:flutter/material.dart';

class ParcialHeader extends StatelessWidget {
  final String materia, sigla;
  final int cor;
  final ParcialStatus status;

  const ParcialHeader({
    Key key,
    @required this.materia,
    @required this.sigla,
    @required this.cor,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(cor),
      ),
      title: Text(materia),
      subtitle: Text(
        status.title,
        style: Theme.of(context).textTheme.subtitle.copyWith(color: status.cor),
      ),
    );
  }
}
