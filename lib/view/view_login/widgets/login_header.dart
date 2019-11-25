import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.2,
      child: const Image(
        image: AssetImage('assets/images/curso_logo2.png'),
      ),
    );
  }
}
