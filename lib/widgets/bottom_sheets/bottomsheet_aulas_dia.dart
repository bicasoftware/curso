import 'package:curso/container/calendario.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class BottomSheetAulasDia extends StatelessWidget {
  final List<AulasSemanaDTO> aulasSemana;

  const BottomSheetAulasDia({
    @required this.aulasSemana,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            Strings.selecioneMateriaProva,
            textAlign: TextAlign.center,
            style: CustomThemes.bottomSheetHeader,
          ),
        ),
        const PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
        Column(
          children: [
            for (final aula in aulasSemana)
              ListTile(
                onTap: () => Navigator.of(context).pop(aula.idMateria),
                leading: MateriaColorContainer(color: Color(aula.cor), size: 32),
                title: Text(aula.nome),
                trailing: Text(aula.sigla, style: theme.textTheme.caption),
              )
          ],
        ),
      ],
    );
  }
}
