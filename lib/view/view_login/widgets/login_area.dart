import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/login_utils.dart';
import 'package:curso/view/view_login/widgets/cadastro_button.dart';
import 'package:curso/view/view_signin/view_signin.dart';
import 'package:curso/widgets/login_area_container.dart';
import 'package:curso/widgets/login_textarea.dart';
import 'package:curso/widgets/rounded_material_button.dart';
import 'package:flutter/material.dart';

class LoginArea extends StatefulWidget {
  const LoginArea({
    @required this.validateLogin,
    Key key,
  }) : super(key: key);

  final Function(String, String) validateLogin;

  @override
  _LoginAreaState createState() => _LoginAreaState();
}

class _LoginAreaState extends State<LoginArea> {
  GlobalKey<FormState> _formKey;
  TextEditingController emailCt, passCt;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    emailCt = TextEditingController(text: "");
    passCt = TextEditingController(text: "");
  }

  @override
  void dispose() {
    emailCt.dispose();
    passCt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 64),
            LoginAreaContainer(
              children: <Widget>[
                LoginTextArea(
                  controller: emailCt,
                  hintText: Strings.emailTest,
                  validator: LoginUtils.validaEmail,
                ),
                const SizedBox(height: 4),
                LoginTextArea(
                  controller: passCt,
                  isPassword: true,
                  hintText: Strings.digiteSenha,
                  validator: LoginUtils.validaSenha,
                ),
              ],
            ),
            const SizedBox(height: 56),
            RoundedButton(
              color: Colors.white,
              label: Strings.entrar,
              onPressed: () => _validateLogin(emailCt.text, passCt.text),
            ),
            LinkButton(
              label: Strings.cadastrar,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => ViewSignIn(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _validateLogin(String email, String pass) {
    final state = _formKey.currentState;
    final bool isValidated = state.validate();
    if (isValidated) {
      state.save();
      widget.validateLogin(emailCt.text, passCt.text);
    }
  }
}
