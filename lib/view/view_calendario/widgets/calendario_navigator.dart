import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class CalendarioNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
          ),
          onPressed: () {
            b.decMes();
          },
          splashColor: Colors.white,
        ),
        Expanded(
          child: StreamBuilder<int>(
            stream: b.outMes,
            initialData: 1,
            builder: (context, snapshot) {
              return Text(
                Arrays.meses[snapshot.data - 1],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_right,
            //color: Colors.white,
          ),
          onPressed: () => b.incMes(),
          splashColor: Colors.white,
        ),
      ],
    );
  }
}
