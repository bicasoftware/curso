import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/view_calendario.dart';
import 'package:curso/view/view_info/view_info.dart';
import 'package:curso/view/view_periodos/view_periodos.dart';
import 'package:flutter/material.dart';

class ViewHomeBuilder {
  static AppBar get appBar {
    return AppBar(
      title: Text("iCurso"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => print("Teste"),
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
      padding: EdgeInsets.all(8),
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
}
