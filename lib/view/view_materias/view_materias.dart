import 'package:curso/bloc/bloc_materias.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/events/EventsMaterias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_materias/view_materias_builder.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return BlocBuilder<EventsMaterias, List<Materias>>(
      bloc: b,
      builder: (c, List<Materias> materias) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.materias),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(materias),
            ),
          ),
          body: ViewMateriasBuilder.listViewMaterias(
            materias: materias,
            onTap: (Materias m, int pos) async {
              ViewMateriasInsertResult result = await Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (c) => ViewMateriasInsert(materia: m, pos: pos),
                ),
              );

              if (result != null) {
                b.dispatch(UpdateMateria(materia: result.materia, pos: result.pos));
              }
            },
            onLongTap: (materia) async {
              final result = await Dialogs.showRemoveDialog(
                context: context,
                title: Strings.opcoes,
              );
              if (result != null) {                
                b.dispatch(DeleteMateria(materia: materia));
              }
            },
          ),
          floatingActionButton: ViewMateriasBuilder.fab(
            () async {
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
                b.dispatch(InsertMateria(result.materia));
              }
            },
          ),
        );
      },
    );
  }
}