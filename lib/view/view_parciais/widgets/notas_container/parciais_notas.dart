import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:curso/view/view_parciais/widgets/notas_container/parcial_nota_progress.dart';
import 'package:curso/view/view_parciais/widgets/notas_container/parcial_notas_item.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class ParciaisNotas extends StatelessWidget {
  final List<Notas> notas;
  final double notaAprovacao;
  final double notaAtual;
  final ParciaisStatus status;

  const ParciaisNotas({
    Key key,
    @required this.notas,
    @required this.notaAprovacao,
    @required this.notaAtual,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(Strings.provas),
      children: <Widget>[
        Column(
          children: <Widget>[
            for (final prova in notas)
              ParcialNotasItem(
                nota: prova,
                medAprov: notaAprovacao,
              )
          ],
        ),
        PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
        ParcialNotaProgress(
          notaAtual: notaAtual,
          notaAprov: notaAprovacao,
          status: status,
        ),
      ],
    );
  }
}
