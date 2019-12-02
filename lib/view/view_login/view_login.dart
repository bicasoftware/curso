import 'package:curso/custom_themes.dart';
import 'package:curso/home_view.dart';
import 'package:curso/models/login_dto.dart';
import 'package:curso/services/login_service.dart';
import 'package:curso/services/response_error.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/storage_utils.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewLogin extends StatefulWidget {
  @override
  _ViewLoginState createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  void showLoginFailMessage(ResponseError error) {
    Flushbar(
      title: Errors.falhaEntrar,
      message: error.error,
      duration: const Duration(seconds: 5),
      backgroundColor: CustomThemes.lightTheme.primaryColorDark,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomThemes.lightTheme,
      home: SafeArea(
        top: true,
        bottom: true,
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
                      showLoginFailMessage(response);
                    } else if (response is LoginDto) {
                      await StorageUtils.putSignInfo(response.email, response.token);
                      Navigator.pop(context);
//                      await Navigator.pushReplacement(
//                        context,
//                        MaterialPageRoute(
//                          builder: (_) => ViewCheckState(),
//                        ),
//                      );
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
