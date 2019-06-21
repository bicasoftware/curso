import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/multiobserver.dart';
import 'package:flutter/material.dart';

class DropDownPeriodos extends StatelessWidget {
  final ThemeData theme;

  const DropDownPeriodos({Key key, @required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return MultiObserver(
      streams: [b.outCurrentPeriodo, b.outListPeriodos],
      onSuccess: (BuildContext context, List data) {
        return Theme(
          data: theme,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Periodos>(
              value: data[0],
              onChanged: (Periodos p) => b.setCurrentPeriodoId(p.id),
              items: [
                for (final per in data[1])
                  DropdownMenuItem<Periodos>(
                    child: Text("${per.numPeriodo}º ${Strings.periodo} "),
                    value: per,
                  )
              ],
            ),
          ),
        );
      },
    );
    /* return PairStreamAwaiter<Periodos, List<Periodos>>(
      stream1: b.outCurrentPeriodo,
      stream2: b.outListPeriodos,
      buildWidget: (Periodos currentPeriodo, List<Periodos> list) {
        return Theme(
          data: theme,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Periodos>(
              value: currentPeriodo,
              onChanged: (Periodos p) => b.setCurrentPeriodoId(p.id),
              items: [
                for (final per in list)
                  DropdownMenuItem<Periodos>(
                    child: Text("${per.numPeriodo}º ${Strings.periodo} "),
                    value: per,
                  )
              ],
            ),
          ),
        );
      },
    ); */
  }
}
