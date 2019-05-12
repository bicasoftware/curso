import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_horario_aulas/view_horario_aulas_result.dart';
import 'package:curso/widgets/squared_card.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';

class ViewHorarioAulas extends StatefulWidget {
  final int ordemAula;
  final TimeOfDay inicio, termino;

  const ViewHorarioAulas({
    Key key,
    @required this.ordemAula,
    @required this.inicio,
    @required this.termino,
  }) : super(key: key);

  _ViewHorarioAulasState createState() => _ViewHorarioAulasState();
}

class _ViewHorarioAulasState extends State<ViewHorarioAulas> {
  int _ordemAula;
  TimeOfDay _inicio, _termino;

  @override
  void initState() {
    super.initState();
    _ordemAula = widget.ordemAula;
    _inicio = widget.inicio;
    _termino = widget.termino;
  }

  _setInicio(TimeOfDay time) {
    setState(() {
      _inicio = time;
    });
  }

  _setTermino(TimeOfDay time) {
    setState(() {
      _termino = time;
    });
  }

  ///Truque barato pra poder mostrar um SnackBar dentro do Scaffold
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Horários ${_ordemAula + 1}ª aula")),
      body: Container(
        padding: EdgeInsets.all(8),
        child: SquaredCard(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TimePickerTile(
                initialTime: _inicio,
                title: Strings.inicioAula,
                onTimeSet: (time) => _setInicio(time),
              ),
              Divider(height: 0),
              TimePickerTile(
                initialTime: _termino,
                title: Strings.terminoAula,
                onTimeSet: (time) => _setTermino(time),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: FlatButton(
          color: Theme.of(context).accentColor,
          child: Text(
            Strings.salvar,
            style: Theme.of(context).textTheme.button.copyWith(
                  color: Colors.white,
                ),
          ),
          onPressed: () => validateHorarios(c: context),
        ),
      ),
    );
  }

  void showErrorSnack({@required BuildContext c, @required String msg}) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(msg)));
  }

  void validateHorarios({@required BuildContext c}) {
    final inicio = DateTime(1970, 1, 1, _inicio.hour, _inicio.minute, 0);
    final termino = DateTime(1970, 1, 1, _termino.hour, _termino.minute, 0);

    if (inicio.isAfter(termino)) {
      showErrorSnack(c: c, msg: Errors.horariosInvalidos);
    } else if (termino.isAtSameMomentAs(inicio)) {
      showErrorSnack(c: c, msg: Errors.horariosIguaisInvalidos);
    } else {
      Navigator.of(c).pop(
        ViewHorarioAulasResult(
          inicio: inicio,
          termino: termino,
          ordemAula: _ordemAula,
        ),
      );
    }
  }
}
