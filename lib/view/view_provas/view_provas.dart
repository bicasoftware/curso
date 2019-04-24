import 'package:curso/container/calendario.dart';
import 'package:curso/container/cronograma.dart';
import 'package:curso/container/notas.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_provas/view_provas_fab.dart';
import 'package:curso/view/view_provas/view_provas_list.dart';
import 'package:curso/view/view_provas_insert/view_provas_insert.dart';
import 'package:flutter/material.dart';

class ViewProvas extends StatefulWidget {
  final List<CronogramaNotas> cronogramas;
  final List<AulasSemanaDTO> aulasSemana;

  const ViewProvas({
    Key key,
    @required this.cronogramas,
    @required this.aulasSemana,
  }) : super(key: key);

  @override
  _ViewProvasState createState() => _ViewProvasState();
}

class _ViewProvasState extends State<ViewProvas> {
  final placeHolder = [
    CronogramaDates(
      date: DateTime(2019, 04, 12),
      materias: [
        CronogramaMaterias(
            cor: Colors.teal.value,
            nome: "Matemática",
            sigla: "MAT",
            id: 1,
            notas: Notas(
              id: 1,
              data: DateTime(2019, 04, 12),
              idMateria: 1,
              nota: 8.0,
            )),
        CronogramaMaterias(
            cor: Colors.red.value,
            nome: "Língua Portuguêsa",
            sigla: "L. Port",
            id: 2,
            notas: Notas(
              id: 2,
              data: DateTime(2019, 04, 12),
              idMateria: 2,
              nota: 8.0,
            )),
        CronogramaMaterias(
            cor: Colors.purple.value,
            nome: "Física",
            sigla: "FIS",
            id: 3,
            notas: Notas(
              id: 3,
              data: DateTime(2019, 04, 12),
              idMateria: 2,
              nota: 9.0,
            )),
      ],
    ),
    CronogramaDates(
      date: DateTime(2019, 04, 20),
      materias: [
        CronogramaMaterias(
            cor: Colors.teal.value,
            nome: "Matemática",
            sigla: "MAT",
            id: 1,
            notas: Notas(
              id: 1,
              data: DateTime(2019, 04, 20),
              idMateria: 1,
              nota: 8.0,
            )),
        CronogramaMaterias(
            cor: Colors.red.value,
            nome: "Língua Portuguêsa",
            sigla: "L. Port",
            id: 2,
            notas: Notas(
              id: 2,
              data: DateTime(2019, 04, 20),
              idMateria: 2,
              nota: 8.0,
            )),
        CronogramaMaterias(
            cor: Colors.purple.value,
            nome: "Física",
            sigla: "FIS",
            id: 3,
            notas: Notas(
              id: 3,
              data: DateTime(2019, 04, 20),
              idMateria: 2,
              nota: 9.0,
            )),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.provas)),
      floatingActionButton: ViewProvasFAB(),
      body: Container(
        child: ProvasList(
          dates: placeHolder,
          onTileTap: (CronogramaDates dates) async {
            final results = await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (c) => ViewProvasInsert(dates: dates, aulasSemana: widget.aulasSemana),
              ),
            );

            if (results != null) {
            }
          },
        ),
      ),
    );
  }
}
