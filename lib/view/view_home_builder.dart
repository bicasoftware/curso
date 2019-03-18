import 'package:flutter/material.dart';

import '../bloc/bloc_main/bloc_main.dart';
import '../utils.dart/Strings.dart';
import '../widgets/calendario/calendario_drop_down_periodos.dart';
import 'view_calendario/view_calendario.dart';
import 'view_info/view_info.dart';
import 'view_periodos/view_periodos.dart';

class ViewHomeBuilder {
  static AppBar appBar({
    @required int pos,
    @required Function(int) onOptionSelected,
    @required BlocMain bloc,
  }) {
    return AppBar(
      //title: dualLineTitle(bloc),
      title: Text(Strings.appName),
      elevation: pos == 1 ? 0 : 2,
      actions: <Widget>[
        pos == 1 ? DropDownPeriodos() : Container(),
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert),
          onSelected: onOptionSelected,
          itemBuilder: (c) {
            return Arrays.opcoes.map((String s) {
              return PopupMenuItem<int>(
                child: Text(s),
                value: 0,
              );
            }).toList();
          },
        ),
      ],
    );
  }

  static Widget bottomBar(int pos, Function(int) onTap) {
    return BottomNavigationBar(
      currentIndex: pos,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_day),
          title: Text(Strings.periodos),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.date_range),
          title: Text(Strings.calendario),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted),
          title: Text(Strings.informacoes),
        ),
      ],
    );
  }

  static Widget body(TabController controller) {
    return Container(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ViewPeriodos(),
          ViewCalendario(),
          ViewInfo(),
        ],
        controller: controller,
      ),
    );
  }

  static Widget fab({
    @required int pos,
    @required VoidCallback onTap,
  }) {
    return pos == 0
        ? FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: onTap,
          )
        : null;
  }
}
