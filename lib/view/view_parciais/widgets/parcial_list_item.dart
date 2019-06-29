import 'package:curso/container/materias.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:curso/view/view_parciais/widgets/parcial_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_header.dart';
import 'package:curso/view/view_parciais/widgets/parcial_notas_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_item.dart';
import 'package:curso/view/view_parciais/widgets/parcial_presenca_progress.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class ParcialListItem extends StatelessWidget {
  final ParciaisMaterias parciais;

  Materias get m => parciais.materia;

  const ParcialListItem({
    Key key,
    @required this.parciais,
  }) : super(key: key);

  String getFaltasText() {
    return "${parciais.numFaltas.toString().padLeft(2, "0")} - ${calcPorcentagemAulas(parciais.numAulasSemestre, parciais.numFaltas).toStringAsFixed(2)} %";
  }

  String getVagasText(){
    return "${parciais.numAulasVagas.toString().padLeft(2, "0")} - ${calcPorcentagemAulas(parciais.numAulasSemestre, parciais.numAulasVagas).toStringAsFixed(2)} %";
  }

  @override
  Widget build(BuildContext context) {
    parciais.notas.sort((a, b) => a.data.compareTo(b.data));
    return Card(
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
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(16),

                  ///TODO - adicionar [Chart] no lugar do [CircleAvatar]
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
                        text: getFaltasText(),
                        // valor: parciais.numFaltas,
                      ),
                      ParcialPresencaItem(
                        cor: Colors.teal,
                        title: Strings.vagas,
                        text: getVagasText(),
                      ),
                      ParcialPresencaItem(
                        cor: Colors.indigo,
                        title: Strings.total,
                        text: parciais.numAulasSemestre.toString().padLeft(2,"0"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParcialNotasHeader(),
          Column(
            children: <Widget>[
              for (final prova in parciais.notas)
                ParcialNotasItem(
                  nota: prova,
                  medAprov: parciais.notaAprovacao,
                )
            ],
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
