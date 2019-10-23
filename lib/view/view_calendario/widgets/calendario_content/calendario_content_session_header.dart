import 'package:flutter/material.dart';

class CalendarioContentSessionHeader extends StatelessWidget {
  const CalendarioContentSessionHeader({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.button.copyWith(color: theme.accentColor),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
