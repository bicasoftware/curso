import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_materias.dart';
import 'package:curso/container/materias.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/dialogs.dart';
import 'package:curso/view/view_materias/view_materias_appbar.dart';
import 'package:curso/view/view_materias/view_materias_list.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert_result.dart';
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
      creator: (_, __) => _bloc,
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
        return WillPopScope(
          onWillPop: () {
            Navigator.of(context).pop(snap.data);
          },
          child: Scaffold(
            backgroundColor: ThemeData.light().canvasColor,
            body: CustomScrollView(
              slivers: [
                ViewMateriasAppBar(
                  onClosePressed: () => Navigator.of(context).pop(snap.data),
                  onAddPressed: () async {
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
                  },
                ),
                ViewMateriasList(
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
              ],
            ),
          ),
        );
      },
    );
  }
}
