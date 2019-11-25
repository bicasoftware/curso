import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    @required this.label,
    this.color,
    Key key,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      child: MaterialButton(
        elevation: 4,
        child: Text(label),
        color: color ?? theme.accentColor,
        onPressed: onPressed,        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
    );
  }
}
