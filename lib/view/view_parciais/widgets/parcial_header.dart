import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:flutter/material.dart';

class ParcialHeader extends StatelessWidget {
  final String materia, sigla;
  final int cor;
  final ParciaisStatus status;

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
      trailing: trailingIcon,
    );
  }

  Widget get trailingIcon {
    if (status is StatusAprovado) {
      return Icon(Icons.thumb_up, color: Colors.green);
    } else if (status is StatusReprovado) {
      return Icon(Icons.thumb_down, color: Colors.red);
    } else if (status is StatusEmAndamento) {
      return Icon(Icons.warning, color: Colors.teal);
    } else if (status is StatusDispensado) {
      return Icon(Icons.time_to_leave, color: Colors.lightGreen);
    } else
      return Icon(Icons.time_to_leave, color: Colors.grey);
  }
}
