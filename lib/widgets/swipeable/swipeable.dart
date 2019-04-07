import 'dart:async';

import 'package:curso/widgets/swipeable/size_change_notifier.dart';
import 'package:flutter/material.dart';

class Swipeable extends StatefulWidget {
  final Widget child;
  final bool isOpen;
  final Color indicatorColor;
  final Icon indicatorIcon;
  final Function(bool) onChanged;

  Swipeable({
    Key key,
    @required this.child,
    @required this.isOpen,
    @required this.onChanged,
    this.indicatorIcon,
    this.indicatorColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SwipeableState();
}

class _SwipeableState extends State<Swipeable> {
  static const double indicatorWidth = 70.0;
  static const double minScrollWidth = indicatorWidth - 10.0;

  ScrollController controller;
  Size childSize;

  void initState() {
    super.initState();
    controller = ScrollController(initialScrollOffset: widget.isOpen ? minScrollWidth : 0);
  }

  bool _handleScrollNotification(dynamic notification) {
    if (notification is ScrollEndNotification) {
      ///Abre o Widget caso ele esteja meio aberto
      if (notification.metrics.pixels >= indicatorWidth / 2 &&
          notification.metrics.pixels < indicatorWidth) {
        scheduleMicrotask(() {
          controller.animateTo(
            minScrollWidth,
            duration: Duration(milliseconds: 600),
            curve: Curves.fastLinearToSlowEaseIn,
          );
        });

        ///Fecha o Widget case esteja meio fechado
      } else if (notification.metrics.pixels >= 0.0 &&
          notification.metrics.pixels < indicatorWidth / 2) {
        scheduleMicrotask(() {
          controller.animateTo(
            0.0,
            duration: Duration(milliseconds: 600),
            curve: Curves.ease,
          );
        });
      }

      ///Chama function mostrando se o Widget está aberto ou fechado
      if (controller.position.pixels == 0) {
        widget.onChanged(false);
      } else if (controller.position.pixels == 60) {
        widget.onChanged(true);
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (childSize == null) {
      return NotificationListener(
        child: LayoutSizeChangeNotifier(child: widget.child),
        onNotification: (LayoutSizeChangeNotification notification) {
          childSize = notification.size;
          scheduleMicrotask(() => setState(() {}));
        },
      );
    }

    ///Itens que vão abaixo no [Stack]
    ///no caso, apenas um [Container] com tamanho fixo (70x70)
    ///com [Color] e [Icon] indicados no widget
    Widget bottomView = Container(
      width: childSize.width,
      height: childSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            width: minScrollWidth,
            height: childSize.height,
            color: widget.indicatorColor ?? Colors.red,
            child: widget.indicatorIcon ?? Icon(Icons.cancel, color: Colors.white),
          ),
        ],
      ),
    );

    ///Lista de items que vão acima do [Stack]
    ///Sendo aqui o [widget] mais um [Container] vazio com tamanho fixo (70x70)
    Widget topView = NotificationListener(
      child: ListView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: childSize.width,
            height: childSize.height,
            color: Theme.of(context).cardColor,
            child: widget.child,
          ),
          Container(
            alignment: Alignment.center,
            width: minScrollWidth,
            height: childSize.height,
          ),
        ],
      ),
      onNotification: _handleScrollNotification,
    );

    return Stack(
      children: <Widget>[
        bottomView,
        Positioned(
          child: topView,
          left: 0.0,
          bottom: 0.0,
          right: 0.0,
          top: 0.0,
        )
      ],
    );
  }
}
