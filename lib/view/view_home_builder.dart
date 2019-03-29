import 'package:curso/widgets/calendario/calendario_drop_down_periodos_light.dart';
import 'package:curso/widgets/casper_appbar.dart';
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
    return CasperAppBar(
      title: Strings.appName,
      trailing: pos == 1 ? DropDownPeriodosLight() : Container(),
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
