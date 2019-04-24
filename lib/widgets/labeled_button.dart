import 'package:flutter/material.dart';

class LabeledButton extends StatelessWidget {
  final double width, height;
  final Icon icon;
  final String label;
  final VoidCallback onPressed;

  const LabeledButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(      
      onTap: onPressed,
      splashColor: Theme.of(context).accentColor,
      child: Container(
        width: width ?? 40,
        height: height ?? 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
