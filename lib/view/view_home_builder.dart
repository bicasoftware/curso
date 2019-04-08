import 'package:curso/widgets/calendario/calendario.dart';
import 'package:flutter/material.dart';

import '../bloc/bloc_main/bloc_main.dart';
import '../utils.dart/Strings.dart';
import 'view_calendario/view_calendario.dart';
import 'view_info/view_info.dart';
import 'view_periodos/view_periodos.dart';

class ViewHomeBuilder {
  static Widget appBar({
    @required int pos,
    @required BlocMain bloc,
  }) {
    return AppBar(
      title: Text(Strings.appName),
      elevation: 0,
      actions: [
        _dropDownPeriodos(pos),
      ],
    );
  }

  static Widget _dropDownPeriodos(int position) {
    return Container(
      child: AnimatedOpacity(
        child: DropDownPeriodos(),
        //child: DropDownPeriodosLight(),
        duration: Duration(milliseconds: 600),
        curve: position == 1 ? Curves.fastOutSlowIn : Curves.linearToEaseOut,
        opacity: position == 1 ? 1 : 0,
      ),
    );
  }

  static Widget bottomBar(BuildContext context, int pos, Function(int) onTap) {
    return BottomNavigationBar(
      currentIndex: pos,
      onTap: onTap,
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
