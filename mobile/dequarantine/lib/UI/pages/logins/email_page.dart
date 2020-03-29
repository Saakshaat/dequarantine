import 'package:dequarantine/constants.dart';
import 'package:dequarantine/models/email_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


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
    Fluttertoast.showToast(msg: "Signing you in");
    _email = _emailController.text;
    _password = _passwordController.text;
    currentUser = EmailUser({
      "email": _email,
      "password": _password
    });

    currentUser.printData();

    bool response = await login.signInEmailToApi();

    if (response) {
      Fluttertoast.showToast(msg: "Redirecting");
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      Fluttertoast.showToast(msg: "Sign in unsuccessful");
    }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
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
              FocusScope.of(context).unfocus();
              _signIn();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("No account?"),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/signup");
                },
                child: Text("Create an account here"),
              )
            ],
          )
        ],
      ),
    );
  }
}