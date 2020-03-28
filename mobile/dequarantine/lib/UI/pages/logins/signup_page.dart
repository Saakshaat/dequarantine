import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _username;

  String _email0;
  String _email1;


  String _password0;
  String _password1;

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

    _password0 = _passwordController0.text;
    _password1 = _passwordController1.text;
    
    print(_username);
    print(_email0);
    print(_email1);
    print(_password0);
    print(_password1);

    
    if (_email0 == _email1) {
      bool signUp = await login.signUpEmail(
        _username,
        _email0,
        _password0,
        _password1,
      ).whenComplete(() => print(bool));

      // if (signUp) {
      //   Navigator.pop(context);
      // } else {
      //   Builder(
      //     builder: (BuildContext context) {
      //       return SnackBar(
      //         content: Text("An error occured"),
      //       );
      //     },
      //   );
      // }
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
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              // hintText: "How do people reach you?",
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
              // hintText: "How do people reach you?",
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
              // hintText: "How do people reach you?",
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
              // hintText: "??",
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
              // hintText: "??",
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