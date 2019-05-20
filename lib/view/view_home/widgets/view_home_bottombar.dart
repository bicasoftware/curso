import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class ViewHomeBottombar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamAwaiter(
      stream: b.outPos,
      widgetBuilder: (c, int pos) {
        return Theme(
          data: ThemeData(
            fontFamily: "FiraSans",
            accentColor: Theme.of(context).accentColor,
            primaryColor: Theme.of(context).primaryColor,
            cardColor: Theme.of(context).cardColor,
          ),
          child: BottomNavigationBar(
            currentIndex: pos,
            onTap: (i) => b.setPos(i),
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
      },
    );
  }
}
