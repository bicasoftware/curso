import 'package:curso/container/materias.dart';
import 'package:curso/container/parciais.dart';
import 'package:curso/utils.dart/double_utils.dart';
import 'package:curso/view/view_parciais/widgets/faltas_chart/parcial_faltas_chart.dart';
import 'package:curso/view/view_parciais/widgets/notas_container/parciais_notas.dart';
import 'package:curso/view/view_parciais/widgets/parcial_header.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class ParcialListItem extends StatelessWidget {
  final ParciaisMaterias parciais;

  Materias get m => parciais.materia;

  const ParcialListItem({
    @required this.parciais,
    Key key,
  }) : super(key: key);

  String getFaltasText() {
    return "${parciais.numFaltas.toString().padLeft(2, "0")} - ${calcPorcentagemAulas(parciais.numAulasSemestre, parciais.numFaltas).toStringAsFixed(2)} %";
  }

  String getVagasText() {
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
          ParcialHeader(
            materia: m.nome,
            cor: m.cor,
            sigla: m.sigla,
            status: parciais.status,
          ),
          const PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParcialFaltasChart(
            totalAulas: parciais.numAulasSemestre,
            faltas: parciais.numFaltas,
            vagas: parciais.numAulasVagas,
            aulasTilDate: parciais.numAulasUntilNow,
          ),
          const PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
          ParciaisNotas(
            status: parciais.status,
            notaAprovacao: parciais.notaAprovacao,
            notaAtual: parciais.notaAtual,
            notas: parciais.notas,
          ),
        ],
      ),
    );
  }
}
