import 'package:flutter/material.dart';

class WidgetSwapper extends StatelessWidget {
  final Widget realWidget, placeholder;
  final bool Function() switchingCase;

  const WidgetSwapper({
    Key key,
    @required this.realWidget,
    @required this.placeholder,
    @required this.switchingCase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return switchingCase() ? realWidget : placeholder;
  }
}
