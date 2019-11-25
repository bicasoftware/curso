import 'package:curso/custom_themes.dart';
import 'package:curso/services/login_service.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewLogin extends StatefulWidget {
  @override
  _ViewLoginState createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        //força a tela de login a ter sempre o tema light
        data: CustomThemes.lightTheme,
        child: Scaffold(
          backgroundColor: CustomThemes.lightTheme.primaryColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 16),
                const LoginHeader(),
                LoginArea(
                  validateLogin: (String email, String pass) async {
                    print("email: $email, pass: $pass");
                    await LoginService.callLogin(email, pass);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
