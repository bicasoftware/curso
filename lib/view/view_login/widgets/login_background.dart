import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Image(
      image: const AssetImage('assets/images/lapis.jpg'),
      height: mq.size.height,
      width: mq.size.width,
      fit: BoxFit.fill,
    );
  }
}
