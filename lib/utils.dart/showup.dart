import 'dart:async';

import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final int delay;
  final Widget child;

  const ShowUp({Key key, this.delay, this.child}) : super(key: key);

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    final curve = CurvedAnimation(
      curve: Curves.decelerate,
      parent: controller,
    );

    animation = Tween<Offset>(
      begin: const Offset(0, .35),
      end: Offset.zero,
    ).animate(curve);

    if (widget.delay == null || widget.delay == 0) {
      controller.forward();
    } else {
      Timer(
        Duration(milliseconds: widget.delay),
        () => controller.forward(),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: SlideTransition(position: animation, child: widget.child),
    );
  }
}
