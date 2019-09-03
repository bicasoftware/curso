import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class ViewHomeBottombar extends StatelessWidget {
  const ViewHomeBottombar({
    @required this.pos,
    @required this.onChanged,
    Key key,
  }) : super(key: key);

  final int pos;
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pos,
      selectedFontSize: 14,
      onTap: onChanged,
      items: [
        BottomNavigationBarItem(
          title: const Text(Strings.periodos),
          icon: Icon(Icons.donut_small),
        ),
        BottomNavigationBarItem(
          title: const Text(Strings.calendario),
          icon: Icon(Icons.date_range),
        ),
        BottomNavigationBarItem(
          title: const Text(Strings.parciais),
          icon: Icon(Icons.format_list_bulleted),
        ),
      ],
    );
  }
}
