import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/actionbar_dropdown_button.dart';
import 'package:curso/widgets/placeholders/awaiting_container.dart';
import 'package:flutter/material.dart';

class DropDownPeriodos extends StatefulWidget {
  const DropDownPeriodos({Key key}) : super(key: key);

  @override
  _DropDownPeriodosState createState() => _DropDownPeriodosState();
}

class _DropDownPeriodosState extends State<DropDownPeriodos> {
  int _posPeriodo;

  @override
  void initState() {
    super.initState();
    _posPeriodo = 1;
  }

  _setPeriodo(int pos) => setState(() => _posPeriodo = pos);

  @override
  Widget build(BuildContext context) {
    final BlocMain bloc = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<List<Periodos>>(
      stream: bloc.outPeriodos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ActionBarDropDownButton<int>(
            currentValue: _posPeriodo,
            onChanged: (int pos) {
              _setPeriodo(pos);
              bloc.setCurrentPeriodoId(pos);
            },
            children: snapshot.data.map((p) {
              return DropdownMenuItem(
                child: PeriodoChild(numPeriodo: p.numPeriodo),
                value: p.id,
              );
            }).toList(),
          );
        } else {
          return AwaitingContainer();
        }
      },
    );
  }
}

class PeriodoChild extends StatelessWidget {
  final int numPeriodo;

  const PeriodoChild({Key key, @required this.numPeriodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$numPeriodoº ${Strings.periodo}",
      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "FiraSans"),
    );
  }
}
