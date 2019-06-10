import 'package:curso/container/materias.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/materia_color_container.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';

class BottomSheetMaterias extends StatelessWidget {
  final List<Materias> materias;

  const BottomSheetMaterias({Key key, @required this.materias}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 10,
                child: Text(
                  Strings.materias,
                  textAlign: TextAlign.center,
                  style: CustomThemes.bottomSheetHeader,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_sweep),
                onPressed: () => Navigator.of(context).pop(-1),
              ),
            ],
          ),
        ),
        PaddedDivider(padding: EdgeInsets.symmetric(horizontal: 16)),
        Expanded(
          child: ListView(
            children: [
              for (final m in materias)
                ListTile(
                  onTap: () => Navigator.of(context).pop(m.id),
                  leading: MateriaColorContainer(color: Color(m.cor), size: 32),
                  title: Text(m.nome),
                  trailing: Text(m.sigla, style: theme.textTheme.caption),
                )
            ],
          ),
        ),
      ],
    );
  }
}
