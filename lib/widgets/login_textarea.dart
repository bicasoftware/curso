import 'package:flutter/material.dart';

class LoginTextArea extends StatelessWidget {
  const LoginTextArea({
    @required this.controller,
    @required this.hintText,
    @required this.validator,
    this.isPassword = false,
    Key key,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isPassword;
  final String hintText;
  final Function(String text) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(isPassword ? Icons.lock : Icons.email),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
