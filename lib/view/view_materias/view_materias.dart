import 'package:curso/container/materias.dart';
import 'package:curso/container/view_materias_insert_result.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_materias/view_materias_list.dart';
import 'package:curso/view/view_materias_insert/view_materias_insert.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:morpheus/page_routes/morpheus_page_route.dart';
import 'package:provider/provider.dart';

import 'bloc/bloc_materias.dart';

class ViewMaterias extends StatefulWidget {
  final List<Materias> materias;
  final int idPeriodo;
  final double medAprov;

  const ViewMaterias({
    @required this.materias,
    @required this.idPeriodo,
    @required this.medAprov,
    Key key,
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
    return Provider<BlocMaterias>(
      child: _Body(idPeriodo: widget.idPeriodo, medAprov: widget.medAprov),
      builder: (BuildContext context) => BlocMaterias(materias: []..addAll(widget.materias)),
      dispose: (BuildContext c, BlocMaterias b) => b.dispose(),
    );
  }
}

class _Body extends StatelessWidget {
  final int idPeriodo;
  final double medAprov;

  const _Body({
    @required this.idPeriodo,
    @required this.medAprov,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMaterias>(context);

    void callInsertMateria() async {
      final ViewMateriasInsertResult result = await Navigator.of(context).push(
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
    }

    return Observer<List<Materias>>(
      stream: b.outMaterias,
      onSuccess: (BuildContext context, List<Materias> materias) {
        return WillPopScope(          
          onWillPop: () async {
            Navigator.of(context).pop(materias);            
            return false;
          },
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
              label: Text(Strings.adicionar),
              icon: Icon(Icons.add),
              onPressed: callInsertMateria,
              heroTag: ObjectKey(Strings.materias),
            ),
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(Strings.materias),
                  floating: true,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(materias),
                  ),
                ),
                ViewMateriasList(
                  materias: materias,
                  onTap: (Materias m, int pos, GlobalKey morpheusKey) async {
                    final ViewMateriasInsertResult result = await Navigator.of(context).push(
                      MorpheusPageRoute(
                        parentKey: morpheusKey,
                        builder: (c) => ViewMateriasInsert(materia: m, pos: pos),
                      ),
                    );

                    if (result != null) {
                      b.updateMaterias(materia: result.materia, pos: result.pos);
                    }
                  },
                  onDelete: (m) => b.deleteMateria(materia: m),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
