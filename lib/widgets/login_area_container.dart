import 'package:flutter/material.dart';

class LoginAreaContainer extends StatelessWidget {
  const LoginAreaContainer({Key key, this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
