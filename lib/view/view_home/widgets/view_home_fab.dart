import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ViewHomeFab extends StatefulWidget {
  const ViewHomeFab({
    @required this.onTap,
    @required this.pos,
    Key key,
  }) : super(key: key);

  final VoidCallback onTap;
  final int pos;

  @override
  _ViewHomeFabState createState() => _ViewHomeFabState();
}

class _ViewHomeFabState extends State<ViewHomeFab> with SingleTickerProviderStateMixin {
  final Duration duration = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    final angle = Tween(begin: 0 / 360, end: -90 / 360);
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> anim) {
        final scaleTween = TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
          TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 1),
        ]);
        return ScaleTransition(
          scale: scaleTween.animate(anim),
          child: RotationTransition(
            turns: widget.pos == 0 ? angle.animate(anim) : angle.animate(ReverseAnimation(anim)),
            child: FadeTransition(
              opacity: anim,
              child: child,
            ),
          ),
        );
      },
      child: widget.pos == 0
          ? FloatingActionButton(
              key: UniqueKey(),
              elevation: 1,
              child: Icon(Icons.add),
              onPressed: widget.onTap,
            )
          : Container(
              width: 0,
              height: 0,
              key: UniqueKey(),
            ),
    );
  }
}
