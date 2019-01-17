import 'package:curso/container/CronogramaContainer.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/widgets/CronogramaItem.dart';
import 'package:curso/widgets/WeekDayHeader.dart';
import 'package:flutter/material.dart';

class Cronograma extends StatelessWidget {
  final Periodos periodo;

  const Cronograma({Key key, this.periodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final length = periodo.aulasDia * 7;

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 7,
      childAspectRatio: 1,
      children: List.generate(length, (i) {
        return CronogramaItem(
          container: CronogramaContainer(
            ordemAula: 0, corMateria: Colors.red, sigla: "TRT"
          ),
        );
      }),
    );
  }

  List<CronogramaContainer> getList(int gridLength, Periodos p){



    return List<CronogramaContainer>();
  }
}
