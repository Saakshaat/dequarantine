import 'dart:convert' as convert;
import 'dart:core';

import 'package:dequarantine/UI/widgets/logins/outline_button.dart';
import 'package:dequarantine/logic/functions/signin_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}
          
class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.10;
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.15;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Dequarantine", style: Theme.of(context).textTheme.headline1,)),

          Text("Find online events that rejuvenate you.", style: Theme.of(context).textTheme.bodyText1,),

          Text("Connect to your community and wellbeing during Quarantine.", style: Theme.of(context).textTheme.bodyText1,),

          OutlineButtonLandingPage(
            text: "Sign in with email",
            route: "/email",
            pop: true,
          ),

          GoogleSignInButton(
            onPressed: () => handleSignIn(),
          ),

          OutlineButtonLandingPage(
            text: "Continue without signing in",
            route: "/home",
            pop: false
          ),
        ],
      ),
    );
  }
}