import 'package:curso/utils.dart/random_utils.dart';
import 'package:flutter/material.dart';

class HorarioAulaChip extends StatelessWidget {
  const HorarioAulaChip({
    Key key,
    this.text,
    this.icon,
    this.color,
  }) : super(key: key);
  
  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      elevation: 1,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      avatar: Icon(
        icon ?? Icons.timeline,
        color: getForegroundColorByLuminance(color),
      ),
      label: Text(
        text,
        style: TextStyle(fontSize: 14, color: getForegroundColorByLuminance(color)),
      ),
      backgroundColor: color ?? Theme.of(context).accentColor,
    );
  }
}
