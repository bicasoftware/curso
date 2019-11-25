import 'package:curso/custom_themes.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:curso/view/view_login/widgets/login_header.dart';
import 'package:curso/view/view_signin/signin_area.dart';
import 'package:flutter/material.dart';

class ViewSignIn extends StatelessWidget {
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
                SignInArea(
                  doSignIn: (String email, String pass) async {
                    print("email: $email, pass: $pass");
                    //TODO - Enviar cadastro servidor
//                    await LoginService.callLogin(email, pass);
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
