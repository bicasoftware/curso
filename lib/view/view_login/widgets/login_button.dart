import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/rounded_material_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({@required this.validateLogin, Key key}) : super(key: key);

  final VoidCallback validateLogin;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      color: Colors.white,
      label: Strings.entrar,
      onPressed: validateLogin,
    );
  }
}
