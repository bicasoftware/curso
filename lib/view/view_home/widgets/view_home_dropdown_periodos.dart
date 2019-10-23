import 'package:curso/view/view_calendario/widgets/dropdown_periodos.dart';
import 'package:flutter/material.dart';

class ViewHomeDropdownPeriodos extends StatelessWidget {
  const ViewHomeDropdownPeriodos({Key key, this.pos}) : super(key: key);

  final int pos;
  static const int _animTime = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedOpacity(
        child: const DropDownPeriodos(),
        duration: const Duration(milliseconds: _animTime),
        curve: pos == 1 ? Curves.fastOutSlowIn : Curves.linearToEaseOut,
        opacity: pos == 1 ? 1 : 0,
      ),
    );
  }
}
