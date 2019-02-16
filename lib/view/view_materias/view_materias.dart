import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../bloc/BlocMaterias.dart';
import '../../container/materias.dart';
import '../../utils.dart/Strings.dart';
import '../../utils.dart/dialogs.dart';
import '../view_materias_insert/view_materias_insert.dart';
import '../view_materias_insert/view_materias_insert_result.dart';
import 'view_materias_builder.dart';

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
  ViewMateriasState createState() {
    return ViewMateriasState();
  }
}

class ViewMateriasState extends State<ViewMaterias> {
  BlocMaterias _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocMaterias(materias: []..addAll(widget.materias));
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocMaterias>(
      bloc: _bloc,
      child: _Body(idPeriodo: widget.idPeriodo, medAprov: widget.medAprov),
    );
  }
}

class _Body extends StatelessWidget {
  final int idPeriodo;
  final double medAprov;

  const _Body({Key key, @required this.idPeriodo, @required this.medAprov}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMaterias>(context);

    return StreamBuilder<List<Materias>>(
      initialData: [],
      stream: b.outMaterias,
      builder: (BuildContext context, AsyncSnapshot<List<Materias>> snap) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.materias),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(snap.data),
            ),
          ),
          body: ViewMateriasBuilder.listViewMaterias(
            materias: snap.data,
            onTap: (Materias m, int pos) async {
              ViewMateriasInsertResult result = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (c) => ViewMateriasInsert(materia: m, pos: pos),
                ),
              );

              if (result != null) {
                b.updateMaterias(materia: result.materia, pos: result.pos);
              }
            },
            onLongTap: (materia) async {
              final result = await Dialogs.showRemoveDialog(
                context: context,
                title: Strings.opcoes,
              );
              if (result != null) {
                b.deleteMateria(materia: materia);
              }
            },
          ),
          floatingActionButton: ViewMateriasBuilder.fab(() async {
            ViewMateriasInsertResult result = await Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (c) {
                  return ViewMateriasInsert(
                    materia: Materias(
                      cor: Colors.indigo.value,
                      idPeriodo: idPeriodo,
                      freq: true,
                      medAprov: medAprov,
                    ),
                  );
                },
              ),
            );

            if (result != null) {
              b.insertMateria(materia: result.materia);
            }
          }),
        );
      },
    );
  }
}
