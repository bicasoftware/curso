import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:curso/view/view_parciais/parcial_status.dart';
import 'package:curso/view/view_parciais/widgets/parcial_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_progress.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class ParcialListItem extends StatelessWidget {
  static final List<Pair<DateTime, double>> notas = [
    Pair(first: DateTime.now(), second: 10.0),
    Pair(first: DateTime.now().add(Duration(days: 1)), second: 8.5),
    Pair(first: DateTime.now().add(Duration(days: 10)), second: 4.8),
  ];

  const ParcialListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Item com [nome da matéria, sigla, cor da matéria e indicador de status]
          ParcialHeader(
            materia: "Matemática",
            cor: Colors.teal.value,
            sigla: "MAT",
            status: ParcialStatus.emAndamento(),
          ),
          PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),

          ///Item contendo [chart] de faltas, vagas e total de aulas
          Row(
            children: [
              ///TODO - adicionar [Chart] aqui
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: CircleAvatar(backgroundColor: Colors.red, maxRadius: 50),
                ),
              ),

              ///Lista contendo número de [faltas] [vagas] e [total]
              Expanded(
                flex: 6,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ParcialPresencaItem(
                        cor: Colors.red,
                        title: Strings.faltas,
                        valor: 2,
                      ),
                      ParcialPresencaItem(
                        cor: Colors.teal,
                        title: Strings.vagas,
                        valor: 6,
                      ),
                      ParcialPresencaItem(
                        cor: Colors.indigo,
                        title: Strings.total,
                        valor: 200,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParcialNotasHeader(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: notas.length,
            itemBuilder: (_, i) => ParcialNotasItem(data: notas[i].first, nota: notas[i].second),
          ),
          PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParcialPresencaProgress(
            media: 8.5,
            notaAprov: 7.5,
            status: ParcialStatus.aprovado(),
          ),
        ],
      ),
    );
  }
}
