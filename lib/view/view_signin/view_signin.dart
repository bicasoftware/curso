import 'package:curso/custom_themes.dart';
import 'package:curso/database/db_provider.dart';
import 'package:curso/database/db_seeder.dart';
import 'package:curso/home_view.dart';
import 'package:curso/services/login_service.dart';
import 'package:curso/services/response_error.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/storage_utils.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:curso/view/view_login/widgets/login_header.dart';
import 'package:curso/view/view_signin/signin_area.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
//TODO - Testar Login e cadastro. COMMITAR
class ViewSignIn extends StatefulWidget {
  @override
  _ViewSignInState createState() => _ViewSignInState();
}

class _ViewSignInState extends State<ViewSignIn> {
  void showLoginFailMessage(String error) {
    Flushbar(
      title: Errors.falhaEntrar,
      message: error,
      duration: const Duration(seconds: 5),
      backgroundColor: CustomThemes.lightTheme.primaryColorDark,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
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
                    final result = await LoginService.callCadastro(email, pass);
                    if (result is Map<String, dynamic>) {
                      await StorageUtils.putSignInfo(result['email'], result['token']);
                      await DbSeeder.applySignInSeed(await DBProvider.instance);
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ViewCheckState(),
                        ),
                      );
                    } else if (result is ResponseError) {
                      showLoginFailMessage(result.error);
                    } else {
                      showLoginFailMessage(result.error);
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
