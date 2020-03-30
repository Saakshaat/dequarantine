import 'package:dequarantine/logic/functions/sign_in_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInWithEmailPage extends StatefulWidget {
  @override
  _SignInWithEmailPageState createState() => _SignInWithEmailPageState();
}

class _SignInWithEmailPageState extends State<SignInWithEmailPage> {
  bool obscurePassword = true;

  String _email;
  String _password;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  final passwordFocus = FocusNode();

  double _opacity = 0;
  String _error = "";

  void _signIn() async {
    Fluttertoast.showToast(
      msg: "Signing you in"
    );

    _email = _emailController.text;
    _password = _passwordController.text;

    Map signInReturned = await signInWithEmail(_email, _password);

    switch (signInReturned["code"]) {
      case true:
        Fluttertoast.showToast(
          msg: "Sign in successful"
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          (Route<dynamic> route) => false //user can't come back to login screen
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Sign in failed"
        );
        setState(() {
          _opacity = 1;
          _error = signInReturned["body"].toString();
        });
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1),
            child: Text(_error, style: TextStyle(color: Colors.red[300])),
          ),
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