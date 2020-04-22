import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jazzed/backend/auth/email_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EmailSignIn(),
      child: LoginUI(),
    );
  }
}

class LoginUI extends StatelessWidget {
  final passwordFocus = FocusNode();
  final emailFocus = FocusNode();

  void navigate(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final emailSignIn = Provider.of<EmailSignIn>(context);

    if (emailSignIn.isLoggedIn) {
      Future.delayed(Duration(milliseconds: 0), () {
        navigate(context);
      });
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
              child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: emailSignIn.isLoggedIn ? 0 : 1,
            child: Text(emailSignIn.error),
          )),
          TextField(
            focusNode: emailFocus,
            decoration: InputDecoration(labelText: "Email"),
            controller: emailSignIn.emailController,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocus);
            },
          ),
          TextField(
              focusNode: passwordFocus,
              decoration: InputDecoration(labelText: "Password"),
              controller: emailSignIn.passwordController,
              obscureText: true,
              onEditingComplete: () {
                emailSignIn.signIn();
                FocusScope.of(context).unfocus();
              }),
          FlatButton(
            onPressed: emailSignIn.signIn,
            child: Text("Sign in"),
          ),
          SizedBox(height: 5),
          emailSignIn.attempting == true ? CircularProgressIndicator() : Container(),
        ],
      ),
    );
  }
}
