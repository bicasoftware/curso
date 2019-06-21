import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/custom_themes.dart';
import 'package:curso/utils.dart/date_utils.dart';
import 'package:curso/utils.dart/observer.dart';
import 'package:flutter/material.dart';

class CalendarioNavigator extends StatefulWidget {
  const CalendarioNavigator({Key key}) : super(key: key);

  @override
  _CalendarioNavigatorState createState() => _CalendarioNavigatorState();
}

class _CalendarioNavigatorState extends State<CalendarioNavigator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);
    return Container(
      color: CustomThemes.lightTheme.cardColor,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () => b.decMes(),
            splashColor: Colors.white,
          ),
          Expanded(
            child: Observer<DateTime>(
              stream: b.outSelectedDate,
              onSuccess: (_, DateTime data) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 150),
                  transitionBuilder: (w, Animation<double> a) {
                    final scaleTween = TweenSequence([
                      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 1),
                      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 1),
                    ]);
                    return ScaleTransition(
                      scale: scaleTween.animate(a),
                      child: FadeTransition(
                        opacity: a,
                        child: w,
                      ),
                    );
                  },
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
            onPressed: () => b.incMes(),
            splashColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
