import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_calendario/widgets/dropdown_periodos.dart';
import 'package:flutter/material.dart';

class ViewHomeDropdownPeriodos extends StatelessWidget {
  final int pos;
  static const int _animTime = 300;

  const ViewHomeDropdownPeriodos({Key key, this.pos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedOpacity(
        child: DropDownPeriodos(
          theme: CustomThemes.primaryColorThemeData,
        ),
        duration: Duration(milliseconds: _animTime),
        curve: pos == 1 ? Curves.fastOutSlowIn : Curves.linearToEaseOut,
        opacity: pos == 1 ? 1 : 0,
      ),
    );
  }
}
