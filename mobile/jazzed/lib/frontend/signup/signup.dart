import 'package:flutter/material.dart';
import 'package:jazzed/backend/auth/email_sign_up.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailSignUp(),
      child: SignUpUI(),
    );
  }
}

class SignUpUI extends StatelessWidget {
  final bool obscurePassword = true;

  final FocusNode emailFocus0 = FocusNode();
  final FocusNode emailFocus1 = FocusNode();
  final FocusNode passwordFocus0 = FocusNode();
  final FocusNode passwordFocus1 = FocusNode();

  void navigate(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final signUp = Provider.of<EmailSignUp>(context);

    if (signUp.success) {
      Future.delayed(Duration(milliseconds: 0), () {
        navigate(context);
      });
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            signUp.error,
            style: TextStyle(color: Colors.red, fontSize: 10),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: "Username",
            ),
            autofocus: true,
            controller: signUp.usernameController,
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
            controller: signUp.email1Controller,
            onChanged: (text) {
              signUp.email2Controller.value = TextEditingValue(text: text);
            },
            onEditingComplete: () {
              signUp.email2Controller.value = TextEditingValue(text: "");
              FocusScope.of(context).requestFocus(emailFocus1);
            },
          ),
          TextFormField(
            focusNode: emailFocus1,
            decoration: const InputDecoration(
                icon: Icon(Icons.email),
                labelText: "Confirm email",
                hintText: "Sike, type it again"),
            controller: signUp.email2Controller,
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
            controller: signUp.password1Controller,
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
            controller: signUp.password2Controller,
            obscureText: obscurePassword,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
          ),
          FlatButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              signUp.signUp();
            },
            child: Text("sign up"),
          )
        ],
      ),
    );
  }
}
