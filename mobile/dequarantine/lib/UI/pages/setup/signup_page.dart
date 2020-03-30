import 'package:dequarantine/logic/functions/signup_functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username;

  String _email0;
  String _email1;


  String _password0;
  String _password1;

  double _opacity = 0;
  String _errorText = "";

  TextEditingController _usernameController;

  TextEditingController _emailController0;
  TextEditingController _emailController1;

  
  TextEditingController _passwordController0;
  TextEditingController _passwordController1;

  bool obscurePassword = true;

  final emailFocus0 = FocusNode();
  final emailFocus1 = FocusNode();
  
  final passwordFocus0 = FocusNode();
  final passwordFocus1 = FocusNode();


  void _signUp() async {
    _username = _usernameController.text;
    _email0 = _emailController0.text;
    _email1 = _emailController1.text;
    _password0 = _passwordController1.text;    
    _password1 = _passwordController1.text;


    if (_email0 == _email1) {
      Fluttertoast.showToast(
        msg: "Signing you up"
      );

      Map signUpReturned = await signUpEmail(_username, _email0, _password0, _password1);

      print(signUpReturned);

      if (signUpReturned["code"]) {
        Fluttertoast.showToast(
          msg: "Sign up successful, redirecting"
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/home",
          
          //user can't come back to login screen
          (Route<dynamic> route) => false
        );
      } else {
        int errorLength = signUpReturned["body"].toString().length - 1;
        setState(() {
          _opacity = 1;
          _errorText = signUpReturned["body"].toString().substring(1, errorLength);
        });
      }

    } else {
      Fluttertoast.showToast(
        msg: "An error occured"
      );

      setState(() {
        _opacity = 1;
        _errorText = "Emails don't match";
      });
    }

  }


  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();

    _emailController0 = TextEditingController();
    _emailController1 = TextEditingController();

    _passwordController0 = TextEditingController();
    _passwordController1 = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(milliseconds: 1000),
            child: Text(_errorText, style: TextStyle(color: Colors.red, fontSize: 10),),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: "Username",
            ),
            autofocus: true,
            controller: _usernameController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(emailFocus0);
            },
          ),
          TextFormField(
            focusNode: emailFocus0,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ),
            controller: _emailController0,
            onChanged: (text) {
              _emailController1.value = TextEditingValue(text: text);
            },
            onEditingComplete: () {
              _emailController1.value = TextEditingValue(text: "");
              FocusScope.of(context).requestFocus(emailFocus1);
            },
          ),
          TextFormField(
            focusNode: emailFocus1,
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Confirm email",
              hintText: "Sike, type it again"
            ),
            controller: _emailController1,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocus0);
            },
          ),
          TextFormField(
            focusNode: passwordFocus0,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            controller: _passwordController0,
            obscureText: obscurePassword,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocus1);
            },
          ),
          TextFormField(
            focusNode: passwordFocus1,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Confirm password",
            ),
            controller: _passwordController1,
            obscureText: obscurePassword,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _signUp();
            },
          ),
          FlatButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              _signUp();
            },
            child: Text("sign up"),
          )
        ],
      ),
    );
  }
}