import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/pair.dart';
import 'package:flutter/material.dart';
import 'package:curso/utils.dart/date_utils.dart';

class CalendarioStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return StreamBuilder<Pair<int, List<DateTime>>>(
      stream: b.outCalendario,
      initialData: Pair(first: 0, second: []),
      builder: (context, snapshot) {
        return Container(
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_left, color: Colors.white),
                onPressed: () => b.decCurrentDate(),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data.second.map((date) {
                    return CalendarioStripCell(
                      date: date,
                      onTap: () => b.setCurrentDate(date),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_right, color: Colors.white),
                onPressed: () => b.incCurrentDate(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CalendarioStripCell extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const CalendarioStripCell({
    Key key,
    @required this.date,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        color: isToday(date) ? Colors.white10 : Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${date.day}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 0.5,
                      color: Colors.white,
                      offset: Offset(0.2, 0.2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Text(
                formatWeekDay(date),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.white24,
                      offset: Offset(0.5, 0.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
