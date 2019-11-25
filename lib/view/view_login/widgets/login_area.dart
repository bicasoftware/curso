import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/utils.dart/login_utils.dart';
import 'package:curso/view/view_login/widgets/cadastro_button.dart';
import 'package:curso/view/view_login/widgets/login_button.dart';
import 'package:curso/view/view_signin/view_signin.dart';
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
  String _email, _pass;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _email = "";
    _pass = "";
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
            Card(
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        hintText: "test@test.com",
                        border: const OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: LoginUtils.validaEmail,
                      onSaved: (String email) => setState(() => _email = email),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: Strings.digiteSenha,
                        prefixIcon: Icon(Icons.lock),
                        border: const OutlineInputBorder(),
                        // labelText: Strings.senha,
                      ),
                      validator: LoginUtils.validaSenha,
                      onSaved: (String pass) => setState(() => _pass = pass),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 56),
            LoginButton(
              label: Strings.entrar,
              onPressed: () {
                final state = _formKey.currentState;
                final bool isValidated = state.validate();
                if (isValidated) {
                  state.save();
                  widget.validateLogin(_email, _pass);
                }
              },
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

  void validateLogin(String email, String pass) {
    final state = _formKey.currentState;
    final bool isValidated = state.validate();
    if (isValidated) {
      state.save();
      widget.validateLogin(_email, _pass);
    }
  }
}
