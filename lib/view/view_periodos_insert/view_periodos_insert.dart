import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_periodos_insert/view_periodos_insert_builder.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ViewPeriodosInsert extends StatefulWidget {
  final Periodos periodo;

  const ViewPeriodosInsert({
    Key key,
    @required this.periodo,
  }) : super(key: key);

  @override
  _ViewPeriodosInsertState createState() => _ViewPeriodosInsertState();
}

class _ViewPeriodosInsertState extends State<ViewPeriodosInsert> {
  static final _formKey = GlobalKey<FormState>();
  DateTime _ini, _end;
  int _aulasDia, _presObrig;
  double _nota;

  final _lastDate = DateTime(2030, 12, 31);

  @override
  void initState() {
    super.initState();
    _ini = widget.periodo.inicio;
    _end = widget.periodo.termino;
    _aulasDia = widget.periodo.aulasDia;
    _presObrig = widget.periodo.presObrig;
    _nota = widget.periodo.medAprov;
  }

  _setDataIni(DateTime ini) => setState(() => _ini = ini);

  _setDataTermino(DateTime end) => setState(() => _end = end);

  _setAulasDia(int pos) => setState(() => _aulasDia = pos);

  _setMedAprov(double aprov) => setState(() => _nota = aprov);

  _setPresObrig(int pos) => setState(() => _presObrig = pos);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.novoPeriodo),
        actions: [
          ViewPeriodosInsertBuilder.saveButton(_formKey, () {
            Navigator.of(context).pop(
              widget.periodo.copyWith(
                id: widget.periodo.id,
                inicio: _ini,
                termino: _end,
                aulasDia: _aulasDia,
                medAprov: _nota,
                presObrig: _presObrig,
              ),
            );
          }),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ViewPeriodosInsertBuilder.inicioDateTile(
              inicio: _ini,
              onTap: () async {
                final dt = await showDatePicker(
                  context: context,
                  initialDate: _ini,
                  firstDate: DateTime(2010, 1, 1),
                  lastDate: _lastDate,
                );

                if (dt != null) {
                  _setDataIni(dt);
                }
              },
            ),
            Divider(),
            ViewPeriodosInsertBuilder.terminoDateTile(
              termino: _end,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: _end,
                  firstDate: _ini,
                  lastDate: _lastDate,
                ).then(
                  (dt) => _setDataTermino(dt),
                );
              },
            ),
            Divider(),
            ViewPeriodosInsertBuilder.aulaDiaTile(_aulasDia, (i) => _setAulasDia(i)),
            Divider(),
            ViewPeriodosInsertBuilder.notaMinimaTile(
              nota: _nota,
              onChanged: (n) => _setMedAprov(n),
            ),
            Divider(),
            ViewPeriodosInsertBuilder.presencaObrigatoriaTile(_presObrig, (i) => _setPresObrig(i)),
          ],
        ),
      ),
    );
  }
}
