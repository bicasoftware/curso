import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ParcialFaltasChart extends StatelessWidget {
  final int faltas, vagas, aulasTilDate, totalAulas;

  const ParcialFaltasChart({
    Key key,
    @required this.totalAulas,
    @required this.faltas,
    @required this.vagas,
    @required this.aulasTilDate,
  }) : super(key: key);

  double get presenca => (aulasTilDate - faltas - vagas).toDouble();

  double get restantes => (totalAulas - aulasTilDate).toDouble();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(Strings.frequencia),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PieChart(
                dataMap: Map<String, double>()
                  ..putIfAbsent("${Strings.faltas} -> $faltas", () => faltas.toDouble())
                  ..putIfAbsent("${Strings.vagas} -> $vagas", () => vagas.toDouble())
                  ..putIfAbsent("${Strings.presencas} -> $presenca", () => presenca)
                  ..putIfAbsent("Restantes", () => restantes),
                chartValuesColor: Colors.black,
                colorList: [Colors.red, Colors.green, Colors.blue, Colors.grey[300]],
                animationDuration: Duration(seconds: 0),
                chartLegendSpacing: 50,
                fontFamily: "FiraSans",
                showChartValues: true,
                showChartValuesOutside: true,
                showChartValuesInPercentage: true,
                legendFontSize: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}