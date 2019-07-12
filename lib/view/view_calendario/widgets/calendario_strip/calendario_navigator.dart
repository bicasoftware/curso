import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/showup.dart';
import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:provider/provider.dart';

class CalendarioNavigator extends StatefulWidget {
  const CalendarioNavigator({Key key}) : super(key: key);

  @override
  _CalendarioNavigatorState createState() => _CalendarioNavigatorState();
}

class _CalendarioNavigatorState extends State<CalendarioNavigator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);
    return Container(
      color: CustomThemes.lightTheme.cardColor,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: b.decMes,
            splashColor: Colors.white,
          ),
          Expanded(
            child: Observer<DateTime>(
              stream: b.outSelectedDate,
              onSuccess: (_, DateTime data) {
                return ShowUp(
                  delay: 300,
                  child: Text(
                    formatFullDayStringAlt(data),
                    key: UniqueKey(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: b.incMes,
            splashColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
