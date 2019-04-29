import 'package:flutter/material.dart';

class HorarioAulaChip extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  final Color iconColor;

  const HorarioAulaChip({Key key, this.text, this.icon, this.color, this.textColor, this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.symmetric(horizontal: 8),
      avatar: Icon(
        icon ?? Icons.timeline,
        color: iconColor ?? Colors.white,
      ),
      label: Text(
        text,
        style: TextStyle(fontSize: 14, color: textColor ?? Colors.white70),
      ),
      backgroundColor: color ?? Theme.of(context).accentColor,
    );
  }
}
