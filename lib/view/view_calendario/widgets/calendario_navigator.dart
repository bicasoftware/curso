import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => b.decMes(),
          splashColor: Colors.white,
        ),
        Expanded(
          child: StreamAwaiter<DateTime>(
            stream: b.outSelectedDate,
            widgetBuilder: (_, DateTime dt) {
              return Text(
                formatFullDayStringAlt(dt),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () => b.incMes(),
          splashColor: Colors.white,
        ),
      ],
    );
  }
}
