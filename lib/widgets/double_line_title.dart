import 'package:flutter/material.dart';

class DoubleLineTitle extends StatelessWidget {
  final String title, subtitle;

  const DoubleLineTitle({Key key, @required this.title, @required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.title.copyWith(color: Colors.white),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}
