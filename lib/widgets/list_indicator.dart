import 'package:flutter/material.dart';

class ListIndicator extends StatelessWidget {
  final String hint;

  static final TextStyle style = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );

  const ListIndicator({Key key, this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).accentColor,
      child: Text(
        hint,
        style: style,
      ),
    );
  }
}
