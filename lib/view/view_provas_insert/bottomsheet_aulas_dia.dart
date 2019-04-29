import 'package:curso/container/calendario.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class BottomSheetAulasDia extends StatelessWidget {
  final List<AulasSemanaDTO> aulasSemana;

  const BottomSheetAulasDia({Key key, @required this.aulasSemana}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            Strings.selecioneMateriaProva,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        Container(
          child: Divider(height: 1),
          margin: EdgeInsets.symmetric(horizontal: 16),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: aulasSemana != null ? aulasSemana.length : 0,
            itemBuilder: (c, i) {
              final m = aulasSemana[i];
              return ListTile(
                onTap: () => Navigator.of(context).pop(m.idMateria),
                leading: CircleAvatar(backgroundColor: Color(m.cor)),
                title: Text(m.nome),
                subtitle: Text(m.sigla),
              );
            },
          ),
        ),
      ],
    );
  }
}
