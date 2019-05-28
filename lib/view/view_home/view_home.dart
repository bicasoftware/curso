import 'package:bloc_provider/bloc_provider.dart';
import 'package:curso/bloc/bloc_main/bloc_main.dart';
import 'package:curso/container/periodos.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_calendario/view_calendario.dart';
import 'package:curso/view/view_home/widgets/view_home_appbar_action.dart';
import 'package:curso/view/view_home/widgets/view_home_bottombar.dart';
import 'package:curso/view/view_parciais/view_parciais.dart';
import 'package:curso/view/view_periodos/view_periodos.dart';
import 'package:curso/widgets/placeholders/stream_builder_child.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ViewHome extends StatefulWidget {
  final int initialPos;
  const ViewHome({Key key, @required this.initialPos}) : super(key: key);

  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> with SingleTickerProviderStateMixin {
  final pages = [
    const ViewPeriodos(),
    const ViewCalendario(),
    const ViewInfo(),
  ];

  BehaviorSubject<int> _subjectPos = BehaviorSubject<int>();
  get outPos => _subjectPos.stream;
  get inPos => _subjectPos.sink;

  @override
  void initState() {
    super.initState();    
    inPos.add(widget.initialPos);
  }

  @override
  void dispose() {
    _subjectPos.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final b = BlocProvider.of<BlocMain>(context);

    return Scaffold(
      backgroundColor: ThemeData.light().canvasColor,
      appBar: AppBar(
        title: Text(Strings.appName),
        elevation: 0,
        actions: [
          StreamAwaiter<int>(
            stream: outPos,
            widgetBuilder: (BuildContext context, int pos) {
              return ViewHomeAppbarAction(
                pos: pos,
                onInsertPeriodos: (Periodos periodo) => b.insertPeriodo(periodo),
              );
            },
          )
        ],        
      ),
      body: StreamAwaiter<int>(
        stream: outPos,
        widgetBuilder: (BuildContext context, int pos) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: pages[pos],
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (Widget child, Animation<double> anim) {
              if (!MediaQuery.of(context).disableAnimations) {
                final scaleTween = TweenSequence([
                  TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 1),
                  TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 1),
                ]);
                return FadeTransition(                  
                  opacity: anim,
                  child: ScaleTransition(
                    scale: scaleTween.animate(anim),
                    child: child,
                  ),
                );
              } else {
                return child;
              }
            },
          );
        },
      ),
      bottomNavigationBar: StreamAwaiter(
        stream: _subjectPos,
        widgetBuilder: (_, int pos) {
          return ViewHomeBottombar(
            pos: pos,
            // onChanged: (pos) => controller.animateTo(pos),
            onChanged: (pos) => inPos.add(pos),
          );
        },
      ),
    );
  }
}
