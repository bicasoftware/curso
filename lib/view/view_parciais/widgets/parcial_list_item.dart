import 'package:curso/container/materias.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/widgets/parcial_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_progress.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';

class ParcialListItem extends StatelessWidget {
  final ParciaisMaterias parciais;

  Materias get m => parciais.materia;

  const ParcialListItem({
    Key key,
    @required this.parciais,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SquaredCard(
      elevation: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Item com [nome da matéria, sigla, cor da matéria e indicador de status]
          ParcialHeader(
            materia: m.nome,
            cor: m.cor,
            sigla: m.sigla,
            status: parciais.status,
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
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ParcialPresencaItem(
                        cor: Colors.red,
                        title: Strings.faltas,
                        valor: parciais.numFaltas,
                      ),
                      ParcialPresencaItem(
                        cor: Colors.teal,
                        title: Strings.vagas,
                        valor: parciais.numAulasVagas,
                      ),
                      ParcialPresencaItem(
                        cor: Colors.indigo,
                        title: Strings.total,
                        valor: parciais.numAulasSemestre,
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
            itemCount: parciais.notas.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, i) {
              return ParcialNotasItem(nota: parciais.notas[i]);
            },
          ),
          PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParcialPresencaProgress(
            notaAtual: parciais.notaAtual,
            notaAprov: parciais.notaAprovacao,
            status: parciais.status,
          ),
        ],
      ),
    );
  }
}
