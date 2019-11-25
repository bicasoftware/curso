import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({
    @required this.label,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white70,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
