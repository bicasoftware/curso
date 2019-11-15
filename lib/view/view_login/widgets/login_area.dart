import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/view/view_login/widgets/cadastro_button.dart';
import 'package:curso/view/view_login/widgets/login_button.dart';
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
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _email,
                      decoration: InputDecoration(
                        hintText: "test@test.com",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: validaEmail,
                      onSaved: (String email) => setState(() => _email = email),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "***",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        // labelText: Strings.senha,
                      ),
                      validator: validaSenha,
                      onSaved: (String pass) => setState(() => _pass = pass),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 56),
            LoginButton(
              validateLogin: () {
                final state = _formKey.currentState;
                final bool isValidated = state.validate();
                if (isValidated) {
                  state.save();
                  widget.validateLogin(_email, _pass);
                }
              },
            ),
            const CadastroButton(),
          ],
        ),
      ),
    );
  }

  String validaEmail(String s) {
    if (!StringUtils.isValidEmail(s)) {
      return Errors.emailInvalido;
    } else {
      return null;
    }
  }

  String validaSenha(String s) {
    if (s.length < 6) {
      return Errors.senhaPoucosCaracteres;
    } else if (!StringUtils.isValidPassword(s)) {
      return Errors.senhaInvalida;
    } else {
      return null;
    }
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
