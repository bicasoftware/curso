import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_materias/view_materias_builder.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert.dart';
import 'package:flutter/material.dart';

class ViewMaterias extends StatefulWidget {
  final List<Materias> materias;
  final int idPeriodo;
  final double medAprov;

  const ViewMaterias({
    Key key,
    @required this.materias,
    @required this.idPeriodo,
    @required this.medAprov,
  }) : super(key: key);

  @override
  _ViewMateriasState createState() => _ViewMateriasState();
}

class _ViewMateriasState extends State<ViewMaterias> {
  List<Materias> _materias;

  @override
  void initState() {
    super.initState();
    _materias = widget.materias;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.materias),
      ),
      body: ViewMateriasBuilder.listViewMaterias(
        materias: _materias,
        onTap: (Materias m) async {
          final materia = await Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (c) => ViewMateriasInsert(
                    materia: m,
                  )));

          if (materia != null) {
            setState(() {
              _materias.firstWhere((it) => it.id == m.id)
                ..copyWith(
                  nome: m.nome,
                  sigla: m.sigla,
                  cor: m.cor,
                );
            });
          }
        },
        onLongTap: (materia) async {
          final bool result = await showDialog(
            context: context,
            builder: (BuildContext c) {
              return SimpleDialog(
                title: Text(materia.nome),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text(Strings.excluir),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ],
              );
            },
          );

          if (result != null) {
            if (result) {
              setState(() => _materias.remove(materia));
            }
          }
        },
      ),
      floatingActionButton: ViewMateriasBuilder.fab(() async {
        final Materias materia = await Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (c) {
              return ViewMateriasInsert(
                materia: Materias(
                  cor: Colors.indigo.value,
                  idPeriodo: widget.idPeriodo,
                  freq: true,
                  medAprov: widget.medAprov,                  
                ),
              );
            },
          ),
        );

        if (materia != null) {
          setState(() {
            _materias.add(materia);
          });
        }
      }),
    );
  }
}
