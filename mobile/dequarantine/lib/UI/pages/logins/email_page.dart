import 'package:dequarantine/constants.dart';
import 'package:dequarantine/models/email_user.dart';
import 'package:flutter/material.dart';


class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  bool obscurePassword = true;

  String _email;
  String _password;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  final passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }


  void _signIn() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    currentUser = EmailUser({
      "email": _email,
      "password": _password
    });

    currentUser.printData();

    bool response = await login.signInEmailToApi();

    if (response) {
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Builder(
        builder: (BuildContext context) {
          return SnackBar(
            content: Text("Sign in unsuccessful"),
          );
        },
      );
    }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              // hintText: "How do people reach you?",
              labelText: "Email",
            ),
            autofocus: true,
            controller: _emailController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocus);
            },
          ),
          TextFormField(
            focusNode: passwordFocus,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              // hintText: "??",
              labelText: "Password",
            ),
            controller: _passwordController,
            obscureText: obscurePassword,
            onEditingComplete: () {
              _signIn();
            },
          ),
        ],
      ),
    );
  }
}