import 'package:curso/custom_themes.dart';
import 'package:curso/services/login_service.dart';
import 'package:curso/services/response_error.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:flushbar/flushbar.dart';
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
                    final response = await LoginService.callLogin(email, pass);
                    if (response is ResponseError) {
                      Flushbar(
                        title: Errors.falhaEntrar,
                        message: response.error,
                        duration: const Duration(seconds: 5),
                        backgroundColor: CustomThemes.lightTheme.primaryColorDark,
                        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                      )..show(context);
                    } else {
                      //TODO - salvar token!
                      //TODO - Carregar tela principal
                      //TODO - adicionar teste na tela inicial, testando se há token salvo
                      //Se sim, carregar dados do servidor,
                      //se não, abrir tela de login
                    }
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
