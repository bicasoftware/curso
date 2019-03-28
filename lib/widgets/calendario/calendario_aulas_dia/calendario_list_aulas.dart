import 'package:curso/container/calendario_content.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:flutter/material.dart';

class AulasDiaList extends StatelessWidget {
  final List<AulasSemanaDTO> aulas;

  const AulasDiaList({Key key, @required this.aulas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: aulas.length,
      shrinkWrap: true,
      itemBuilder: (c, i) {
        final aulasSemana = aulas[i];
        return ListTile(
          leading: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              formatTime(aulasSemana.horario),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          title: Text(aulasSemana.nome),
          trailing: CircleAvatar(
            backgroundColor: Color(aulasSemana.cor),
          ),
        );
      },
      separatorBuilder: (c, i) => Divider(height: 0),
    );
  }
}
