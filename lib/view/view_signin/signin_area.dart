import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/login_utils.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:curso/view/view_login/view_login.dart';
import 'package:curso/widgets/login_area_container.dart';
import 'package:curso/widgets/login_textarea.dart';
import 'package:curso/widgets/rounded_material_button.dart';
import 'package:flutter/material.dart';

class SignInArea extends StatefulWidget {
  const SignInArea({Key key, this.doSignIn}) : super(key: key);

  final Function(String, String) doSignIn;

  @override
  _SignInAreaState createState() => _SignInAreaState();
}

class _SignInAreaState extends State<SignInArea> {
  GlobalKey<FormState> _formKey;
  TextEditingController emailCt, passCt, rtPassCt;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    emailCt = TextEditingController(text: "");
    passCt = TextEditingController(text: "");
    rtPassCt = TextEditingController(text: "");
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
            const SizedBox(height: 32),
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
                  hintText: Strings.digiteSenha,
                  isPassword: true,
                  validator: LoginUtils.validaSenha,
                ),
                const SizedBox(height: 4),
                LoginTextArea(
                  controller: rtPassCt,
                  isPassword: true,
                  hintText: Strings.repitaASenha,
                  validator: (s) => LoginUtils.isSamePassword(passCt.text, rtPassCt.text),
                ),
              ],
            ),
            RoundedButton(
              color: Colors.white,
              label: Strings.cadastrar,
              onPressed: () => _validateLogin(emailCt.text, passCt.text),
            ),
            LinkButton(
              label: Strings.cancelar,
              onPressed: _goBack,
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
      widget.doSignIn(email, pass);
    }
  }

  void _goBack() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ViewLogin(),
      ),
    );
  }
}
