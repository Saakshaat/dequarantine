import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
          
class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GoogleSignInButton(
          onPressed: () async {
            bool loggedIn = await login.googleLogin();
            if (loggedIn) {
              Navigator.pushReplacementNamed(
                context,
                "/home"
              );
            }
          },
        ),
        FlatButton(
          child: Text("Sign in with email"),
          onPressed: () {
            Navigator.pushReplacementNamed(
              context,
              "/email"
            );
          },
        )
      ],
    );
  }
}