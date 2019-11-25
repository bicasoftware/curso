import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/login_utils.dart';
import 'package:curso/view/view_login/login_widgets.dart';
import 'package:curso/view/view_login/view_login.dart';
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
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextFormField(
                      controller: emailCt,
                      decoration: InputDecoration(
                        hintText: "test@test.com",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: LoginUtils.validaEmail,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passCt,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: Strings.digiteSenha,
                        prefixIcon: Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                      ),
                      validator: LoginUtils.validaSenha,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: rtPassCt,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: Strings.repitaASenha,
                        prefixIcon: Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (s) => LoginUtils.isSamePassword(passCt.text, rtPassCt.text),
                    ),
                  ],
                ),
              ),
            ),
            LoginButton(
              label: Strings.cadastrar,
              onPressed: () {
                _validateLogin(emailCt.text, passCt.text);
              },
            ),
            LinkButton(
              label: Strings.cancelar,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => ViewLogin(),
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
      widget.doSignIn(email, pass);
    }
  }
}
