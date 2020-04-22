import 'package:flutter/material.dart';
import 'package:jazzed/main.dart';

class ButtonBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomRaisedButton(
          text: "Login",
          action: () => Navigator.pushNamed(
            context,
            '/login',
          ),
        ),
        CustomRaisedButton(
          text: "Sign up",
          action: () => Navigator.pushNamed(
            context,
            '/signup',
          ),
        ),
        CustomRaisedButton(
          text: "Google",
          action: () => print("GOOGLE")
        )
      ],
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  final dynamic action;
  final String text;

  const CustomRaisedButton({
    @required this.action,
    @required this.text
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: action,
      child: Text(text),
    );
  }
}
