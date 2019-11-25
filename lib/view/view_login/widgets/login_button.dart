import 'package:curso/widgets/rounded_material_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    @required this.label,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;


  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      color: Colors.white,
      label: label,
      onPressed: onPressed,
    );
  }
}
