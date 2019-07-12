import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewHomeBottombar extends StatelessWidget {
  final int pos;
  final Function(int) onChanged;

  const ViewHomeBottombar({
    @required this.pos,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: CustomThemes.lightTheme,
      child: BottomNavigationBar(
        currentIndex: pos,
        selectedFontSize: 14,
        onTap: onChanged,
        items: [
          BottomNavigationBarItem(
            title: Text(Strings.periodos),
            icon: Icon(Icons.donut_small),
          ),
          BottomNavigationBarItem(
            title: Text(Strings.calendario),
            icon: Icon(Icons.date_range),
          ),
          BottomNavigationBarItem(
            title: Text(Strings.parciais),
            icon: Icon(Icons.format_list_bulleted),
          ),
        ],
      ),
    );
  }
}
