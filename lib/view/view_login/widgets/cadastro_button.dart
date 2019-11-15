import 'package:curso/utils.dart/Strings.dart';
import 'package:flutter/material.dart';

class CadastroButton extends StatelessWidget {
  const CadastroButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        Strings.cadastrar,
        style: TextStyle(
          color: Colors.white70,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () {},
    );
  }
}