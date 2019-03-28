import 'package:flutter/material.dart';

class DropDownAction<T> extends StatelessWidget {
  final List<DropdownMenuItem> children;
  final T currentValue;
  final Function(T) onChanged;
  final bool showLine;

  const DropDownAction({
    Key key,
    @required this.children,
    @required this.currentValue,
    @required this.onChanged,
    this.showLine: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(canvasColor: Theme.of(context).primaryColor),
      child: showLine == false
          ? DropdownButtonHideUnderline(
              child: DropdownButton(
                value: currentValue,
                items: children,
                onChanged: (T) => onChanged(T),
              ),
            )
          : DropdownButton(
              value: currentValue,
              items: children,
              onChanged: (T) => onChanged(T),
            ),
    );
  }
}
