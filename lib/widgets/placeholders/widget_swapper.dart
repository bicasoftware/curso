import 'package:flutter/material.dart';

class WidgetSwapper extends StatelessWidget {
  const WidgetSwapper({
    @required this.realWidget,
    @required this.placeholder,
    @required this.switchingCase,
    Key key,
  }) : super(key: key);
  
  final Widget realWidget, placeholder;
  final bool Function() switchingCase;

  @override
  Widget build(BuildContext context) {
    return switchingCase() ? realWidget : placeholder;
  }
}
