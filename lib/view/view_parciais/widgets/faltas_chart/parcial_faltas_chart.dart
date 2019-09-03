import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_parciais/widgets/faltas_chart/parcial_faltas_char_legenda.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ParcialFaltasChart extends StatelessWidget {
  const ParcialFaltasChart({
    @required this.totalAulas,
    @required this.faltas,
    @required this.vagas,
    @required this.aulasTilDate,
    Key key,
  }) : super(key: key);

  final int faltas, vagas, aulasTilDate, totalAulas;

  int get presenca => aulasTilDate - faltas - vagas;

  int get restantes => totalAulas - aulasTilDate;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text(Strings.frequencia),
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
                chartValuesColor: Theme.of(context).textTheme.caption.color,
                colorList: [Colors.red, Colors.green, Colors.blue, Theme.of(context).unselectedWidgetColor],
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
                    cor: Theme.of(context).unselectedWidgetColor,
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
