import 'dart:ui';

import 'package:curso/utils.dart/StringUtils.dart';
import 'package:curso/utils.dart/Strings.dart';
import 'package:curso/widgets/rouded_corner_container.dart';
import 'package:curso/widgets/rounded_material_button.dart';
import 'package:flutter/material.dart';

class ViewLogin extends StatefulWidget {
  @override
  _ViewLoginState createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  TextEditingController ctEmail, ctPass;

  @override
  void initState() {
    super.initState();
    ctEmail = TextEditingController();
    ctPass = TextEditingController();
  }

  @override
  void dispose() {
    ctEmail.dispose();
    ctPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Image(
                image: const AssetImage('assets/images/login_bg.png'),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.10,
                child: Row(
                  children: const <Widget>[
                    Spacer(),
                    Image(
                      image: AssetImage('assets/images/curso_header.png'),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 64),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              RoundedCornerContainer(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  controller: ctEmail,
                                  decoration: InputDecoration(
                                      hintText: "test@test.com",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.email)
                                      // labelText: Strings.email,
                                      ),
                                  validator: (String s) {
                                    if (!StringUtils.isValidEmail(s)) {
                                      return Errors.emailInvalido;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 16),
                              RoundedCornerContainer(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: ctPass,
                                  decoration: InputDecoration(
                                    hintText: "***",
                                    prefixIcon: Icon(Icons.lock),
                                    border: InputBorder.none,
                                    // labelText: Strings.senha,
                                  ),
                                  validator: (String s) {
                                    if (s.length < 6) {
                                      return Errors.senhaPoucosCaracteres;
                                    } else if (!StringUtils.isValidPassword(s)) {
                                      return Errors.senhaInvalida;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 56),
                              RoundedButton(
                                color: Colors.white,
                                label: Strings.entrar,
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Text(
                                  Strings.cadastrar,
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
