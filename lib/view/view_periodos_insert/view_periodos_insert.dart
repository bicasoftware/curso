import 'package:flutter/material.dart';

import '../../container/periodos.dart';
import '../../utils.dart/Strings.dart';
import 'view_periodos_insert_builder.dart';

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

  final _lastDate = DateTime(2030, 12, 31);

  Periodos _periodo;

  @override
  void initState() {
    super.initState();
    _periodo = widget.periodo;
  }

  _setDataIni(DateTime ini) => setState(() => _periodo.inicio = ini);

  _setDataTermino(DateTime end) => setState(() => _periodo.termino = end);

  _setAulasDia(int pos) => setState(() => _periodo.aulasDia = pos);

  _setMedAprov(double aprov) => setState(() => _periodo.medAprov = aprov);

  _setPresObrig(int pos) => setState(() => _periodo.presObrig = pos);

  _setNumPeriodo(int numero) => setState(() => _periodo.numPeriodo = numero);

  Widget _divider() => Divider(height: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.periodo.id == null
              ? Strings.novoPeriodo
              : "${widget.periodo.numPeriodo}º ${Strings.editarPeriodo}",
        ),
        actions: [
          ViewPeriodosInsertBuilder.saveButton(_formKey, () => Navigator.of(context).pop(_periodo))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ViewPeriodosInsertBuilder.numPeriodoTile(
              numPeriodo: _periodo.numPeriodo,
              onChanged: _setNumPeriodo,
            ),
            _divider(),
            ViewPeriodosInsertBuilder.inicioDateTile(
              inicio: _periodo.inicio,
              onTap: () async {
                final dt = await showDatePicker(
                  context: context,
                  initialDate: _periodo.inicio,
                  firstDate: DateTime(2010, 1, 1),
                  lastDate: _lastDate,
                );

                if (dt != null) {
                  _setDataIni(dt);
                }
              },
            ),
            _divider(),
            ViewPeriodosInsertBuilder.terminoDateTile(
              termino: _periodo.termino,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: _periodo.termino,
                  firstDate: _periodo.inicio,
                  lastDate: _lastDate,
                ).then(
                  (dt) => _setDataTermino(dt),
                );
              },
            ),
            _divider(),
            ViewPeriodosInsertBuilder.aulaDiaTile(_periodo.aulasDia, (i) => _setAulasDia(i)),
            Divider(),
            ViewPeriodosInsertBuilder.notaMinimaTile(
              nota: _periodo.medAprov,
              onChanged: (n) => _setMedAprov(n),
            ),
            _divider(),
            ViewPeriodosInsertBuilder.presencaObrigatoriaTile(
              _periodo.presObrig,
              (i) => _setPresObrig(i),
            ),
          ],
        ),
      ),
    );
  }
}
