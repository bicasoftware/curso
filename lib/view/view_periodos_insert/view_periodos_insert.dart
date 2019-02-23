import 'package:curso/widgets/list_indicator.dart';
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

  _onAulaTap(i) {}

  Widget _divider() => Divider(height: 1);

  //TODO - receber Horario e inicio e termino das aulas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ViewPeriodosInsertBuilder.appBar(
        idPeriodo: _periodo.numPeriodo,
        formKey: _formKey,
        onTap: () => Navigator.of(context).pop(_periodo),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          margin: EdgeInsets.all(8),
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListIndicator(
                hint: "Periodo",
              ),
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
              ListIndicator(hint: "Valores de Reprovação"),
              ViewPeriodosInsertBuilder.notaMinimaTile(
                nota: _periodo.medAprov,
                onChanged: (n) => _setMedAprov(n),
              ),
              _divider(),
              ViewPeriodosInsertBuilder.presencaObrigatoriaTile(
                _periodo.presObrig,
                (i) => _setPresObrig(i),
              ),
              _divider(),
              ListIndicator(
                hint: "Aulas e Horários",
              ),
              ViewPeriodosInsertBuilder.aulaDiaTile(_periodo.aulasDia, (i) => _setAulasDia(i)),
              _divider(),
              ViewPeriodosInsertBuilder.listHorarios(
                horarios: _periodo.horarios,
                aulasDia: _periodo.aulasDia,
                onOrdemAulaTap: (i) => _onAulaTap(i),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
