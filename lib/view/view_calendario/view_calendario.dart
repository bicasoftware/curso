import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/widgets/calendario_content/calendario_content_list.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_navigator.dart';
import 'package:curso/view/view_calendario/widgets/calendario_strip/calendario_strip.dart';
import 'package:curso/view/view_calendario/widgets/dropdown_periodos.dart';
import 'package:curso/widgets/padded_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewCalendario extends StatefulWidget {
  const ViewCalendario({Key key}) : super(key: key);

  @override
  ViewCalendarioState createState() => ViewCalendarioState();
}

class ViewCalendarioState extends State<ViewCalendario> {
  @override
  Widget build(BuildContext context) {
    final BlocMain b = Provider.of<BlocMain>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            title: Text(Strings.calendario),
            floating: true,
            actions: <Widget>[
              const DropDownPeriodos(),
              IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: b.toggleBrightness,
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: [
                    Container(
                      color: Theme.of(context).appBarTheme.color,
                      child: Column(
                        children: const <Widget>[
                          CalendarioNavigator(),
                          PaddedDivider(height: 0, padding: EdgeInsets.symmetric(horizontal: 64)),
                          CalendarioStrip(),
                        ],
                      ),
                    ),
                    const CalendarioAulasProvas(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
