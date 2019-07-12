import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/widgets/faltas_chart/parcial_faltas_char_legenda.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ParcialFaltasChart extends StatelessWidget {
  final int faltas, vagas, aulasTilDate, totalAulas;

  const ParcialFaltasChart({
    @required this.totalAulas,
    @required this.faltas,
    @required this.vagas,
    @required this.aulasTilDate,
    Key key,
  }) : super(key: key);

  int get presenca => aulasTilDate - faltas - vagas;

  int get restantes => totalAulas - aulasTilDate;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(Strings.frequencia),
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PieChart(
                dataMap: <String, double>{}
                  ..putIfAbsent("${Strings.faltas} -> $faltas", faltas.toDouble)
                  ..putIfAbsent("${Strings.vagas} -> $vagas", vagas.toDouble)
                  ..putIfAbsent("${Strings.presencas} -> $presenca", () => presenca.toDouble())
                  ..putIfAbsent("Restantes", () => restantes.toDouble()),
                chartValuesColor: Colors.black,
                colorList: [Colors.red, Colors.green, Colors.blue, Colors.grey[300]],
                fontFamily: "FiraSans",
                showChartValuesOutside: true,
                showLegends: false,
              ),
              const Divider(height: 32),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ParciaisFaltasChartLegenda(
                    cor: Colors.red,
                    legenda: Strings.faltas,
                    number: faltas,
                  ),
                  ParciaisFaltasChartLegenda(
                    cor: Colors.green,
                    legenda: Strings.vagas,
                    number: vagas,
                  ),
                  ParciaisFaltasChartLegenda(
                    cor: Colors.blue,
                    legenda: Strings.presencas,
                    number: presenca,
                  ),
                  ParciaisFaltasChartLegenda(
                    cor: Colors.grey[300],
                    legenda: Strings.restantes,
                    number: restantes,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
