import 'package:dequarantine/UI/pages/home/home_page.dart';
import 'package:dequarantine/UI/pages/setup/signin_page.dart';
import 'package:dequarantine/UI/pages/setup/signin_with_email_page.dart';
import 'package:dequarantine/UI/pages/setup/signup_page.dart';
import 'package:dequarantine/logic/models/user.dart';

import 'package:flutter/material.dart';

User currentUser; 

void main() => runApp(MaterialApp(
  initialRoute: "/login",

  routes: {
    "/home" : ( context ) => Material(child: Home()),
    "/login" : ( context ) => Material(child: SignInPage()),
    "/email" : ( context ) => Material(child: SignInWithEmailPage()),
    "/signup" : ( context ) => Material(child: SignUpPage()),
  },

  theme: ThemeData(
    primaryColor: Color.fromRGBO(	105, 240, 174, 1),
    buttonColor: Color.fromRGBO(63, 81, 181, 1),
    backgroundColor: Colors.white60,
      
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 45,
        color: Colors.black,
        fontWeight: FontWeight.w700
      ),

      headline2: TextStyle(
        fontSize: 30,
        color: Colors.black,
        fontWeight: FontWeight.w700
      ),

      bodyText1: TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w500
      ),
    )
  ),

  darkTheme: ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.black87,
    primaryColor: Color.fromRGBO(43, 189, 126, 1),
    buttonColor: Color.fromRGBO(0, 41, 132, 1),

    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 45,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),

      headline2: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),

      bodyText1: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.w500
      ),
    )
  ),
));