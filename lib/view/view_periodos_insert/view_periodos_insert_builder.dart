import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_periodos_insert/horario_aula_tile.dart';
import 'package:flutter/material.dart';
import 'package:helper_tiles/helper_tiles.dart';
import 'package:meta/meta.dart';

import '../../container/horarios.dart';
import '../../utils.dart/Strings.dart';

class ViewPeriodosInsertBuilder {
  static Widget numPeriodoDropdownTile({
    @required int numPeriodo,
    @required Function(int) onChanged,
  }) {
    return DefaultListTile(
      icon: Icons.format_list_numbered,
      leading: Text(Strings.numPeriodo),
      trailing: Theme(
        data: CustomThemes.lightTheme,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: numPeriodo,
            onChanged: onChanged,
            items: List.generate(12, (i) {
              return DropdownMenuItem<int>(
                value: i + 1,
                child: Text("${i + 1}º ${Strings.periodo}"),
              );
            }),
          ),
        ),
      ),
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
}
