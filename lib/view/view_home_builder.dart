import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
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
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: pos,
      onTap: onTap,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(Strings.periodos, style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.calendar_view_day, color: Colors.black),
          activeIcon: Icon(Icons.calendar_view_day, color: Colors.black),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).accentColor,
          title: Text(Strings.calendario, style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.date_range, color: Colors.black),
          activeIcon: Icon(Icons.date_range, color: Colors.black),
        ),
        BubbleBottomBarItem(
          backgroundColor: Theme.of(context).accentColor,
          title: Text("Faltas", style: TextStyle(color: Colors.black)),
          icon: Icon(Icons.format_list_bulleted, color: Colors.black),
          activeIcon: Icon(Icons.format_list_bulleted, color: Colors.black),
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
