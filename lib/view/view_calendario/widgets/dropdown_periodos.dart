import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class DropDownPeriodos extends StatelessWidget {
  const DropDownPeriodos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return MultiObserver(
      streams: [b.outCurrentPeriodo, b.outListPeriodos],
      onSuccess: (BuildContext context, List data) {
        final periodo = data[0];
        final periodos = data[1];
        return Theme(
          data: CustomThemes.darkTheme,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Periodos>(
              value: periodo,
              onChanged: (Periodos p) => b.setCurrentPeriodoId(p.id),
              items: [
                for (final per in periodos)
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
  }
}
