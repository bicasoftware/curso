import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../container/horarios.dart';
import 'package:curso/utils.dart/date_utils.dart';
import '../../utils.dart/Strings.dart';
import '../../widgets/default_list_tile.dart';
import '../../widgets/horario_aula_tile.dart';
import '../../widgets/slider_tile.dart';

class ViewPeriodosInsertBuilder {
  static Widget appBar({
    @required int idPeriodo,
    @required GlobalKey<FormState> formKey,
    @required Function() onTap,
  }) {
    return AppBar(
      title: Text(
        idPeriodo == null ? Strings.novoPeriodo : "$idPeriodoº ${Strings.editarPeriodo}",
      ),
      actions: [saveButton(formKey, onTap)],
    );
  }

/*   static Widget numPeriodoTile({@required int numPeriodo, @required Function(int) onChanged}) {
    return DefaultListTile(
      icon: Icons.confirmation_number,
      leading: Text(Strings.numPeriodo),
      trailing: DropdownButton<int>(
        value: numPeriodo,
        items: List.generate(18, (i) {
          return DropdownMenuItem(
            child: Text("${i + 1} ${Strings.periodo}"),
            value: i + 1,
          );
        }),
        onChanged: onChanged,
      ),
    );
  } */

  static Widget numPeriodoSliderTile(
      {@required double numPeriodo, @required Function(double) onChanged}) {
    return SliderTile(
      initialValue: numPeriodo,
      min: 1,
      max: 18,
      divisions: 18,
      mask: "º período",
      title: Strings.numPeriodo,
      fixedSize: 0,
      onChanged: onChanged,
    );
  }

  static Widget inicioDateTile({@required DateTime inicio, VoidCallback onTap}) {
    return DefaultListTile(
      icon: Icons.calendar_today,
      leading: Text(Strings.inicioPeriodo),
      trailing: Text(formatDate(inicio)),
      onTap: onTap,
    );
  }

  static Widget terminoDateTile({@required DateTime termino, VoidCallback onTap}) {
    return DefaultListTile(
      icon: Icons.date_range,
      leading: Text(Strings.inicioPeriodo),
      trailing: Text(formatDate(termino)),
      onTap: onTap,
    );
  }

  static Widget aulaDiaTileSlider({int aulasDia, Function(double) onChanged}) {
    return SliderTile(
      divisions: 12,
      initialValue: aulasDia.toDouble(),
      min: 1,
      max: 12,
      mask: "",
      fixedSize: 0,
      title: Strings.aulasDia,
      onChanged: onChanged,
    );
  }

  /* static Widget aulaDiaTile(int aulasDia, Function(int) onChanged) {
    return DefaultListTile(
      icon: Icons.format_list_numbered,
      leading: Text(Strings.aulasDia),
      trailing: DropdownButton<int>(
        value: aulasDia,
        items: ListUtils.generateInRange(1, 12, (i) {
          return DropdownMenuItem(
            child: Text("$i"),
            value: i,
          );
        }),
        onChanged: onChanged,
      ),
    );
  } */

  /* static Widget notaMinimaTile({@required double nota, @required Function(double) onChanged}) {
    return DefaultListTile(
      icon: Icons.warning,
      leading: Text(Strings.notaAprovacao),
      trailing: DropdownButton<double>(
        value: nota,
        onChanged: onChanged,
        items: Arrays.mediaAprovacao
            .map((num n) => DropdownMenuItem(child: Text("$n"), value: n.toDouble()))
            .toList(),
      ),
    );
  } */

  static Widget notaMinimaSliderTile(
      {@required double nota, @required Function(double) onChanged}) {
    return SliderTile(
      min: 6,
      max: 9,
      divisions: 6,
      initialValue: nota,
      title: Strings.notaAprovacao,
      mask: "",
      fixedSize: 1,
      onChanged: onChanged,
    );
  }

  /* static Widget presencaObrigatoriaTile(int presObrig, Function(int) onChanged) {
    return DefaultListTile(
      icon: Icons.error_outline,
      leading: Text(Strings.presencaObrigatoria),
      trailing: DropdownButton<int>(
        items:
            List.generate(40, (i) => DropdownMenuItem(child: Text("${i + 60} %"), value: i + 60)),
        value: presObrig,
        onChanged: onChanged,
      ),
    );
  } */

  static Widget presencaObrigatoriaSliderTile(double presObrig, Function(double) onChanged) {
    return SliderTile(
      initialValue: presObrig,
      max: 90,
      min: 50,
      divisions: 8,
      fixedSize: 0,
      mask: "%",
      title: Strings.presencaObrigatoria,
      onChanged: onChanged,
    );
  }

  static Widget saveButton(GlobalKey<FormState> formKey, Function() onTap) {
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: onTap,
    );
  }

  static Widget listHorarios({
    @required int aulasDia,
    @required List<Horarios> horarios,
    @required Function(int, DateTime, DateTime) onOrdemAulaTap,
  }) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: aulasDia,
      itemBuilder: (c, i) {
        return HorarioAulaTile(
          ordemAula: i,
          onOrdemAulaTap: onOrdemAulaTap,
          inicio: horarios.firstWhere((h) => h.ordemAula == i, orElse: () => null)?.inicio ??
              DateTime.now(),
          termino: horarios.firstWhere((h) => h.ordemAula == i, orElse: () => null)?.termino ??
              DateTime.now(),
        );
      },
      separatorBuilder: (c, i) => Divider(height: 1),
    );
  }

  static Widget aulasSemana() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: Arrays.weekDayShort.map((d) {
            return Expanded(
              child: Card(
                margin: EdgeInsets.all(1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Text(d),
                      Divider(),
                      Checkbox(
                        value: false,
                        tristate: false,
                        onChanged: (bool s) => print(s),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );

    // return GridView.builder(
    //   shrinkWrap: true,
    //   physics: NeverScrollableScrollPhysics(),
    //   itemCount: 7,
    //   itemBuilder: (c, i) {
    //     return Card(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
    //       child: Container(
    //         height: 48,
    //         padding: EdgeInsets.all(8),
    //         child: Column(
    //           children: [
    //             Text(Arrays.weekDayShort[i]),
    //             Divider(),
    //             Checkbox(
    //               value: false,
    //               tristate: false,
    //               onChanged: (bool s) => print(s),
    //             )
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 7,
    //     childAspectRatio: 1,
    //   ),
    // );
  }
}
