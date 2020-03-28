import 'package:dequarantine/UI/pages/logins/email_page.dart';
import 'package:dequarantine/UI/pages/logins/login_page.dart';
import 'package:dequarantine/UI/pages/logins/signup_page.dart';
import 'package:dequarantine/UI/pages/main_pages/home_page.dart';
import 'package:flutter/material.dart';



void main() => runApp(MaterialApp(
  initialRoute: "/login",

  routes: {
    "/home" : ( context ) => Material(child: Home()),
    "/login" : ( context ) => Material(child: LoginPage()),
    "/email" : ( context ) => Material(child: EmailPage()),
    "/signup" : ( context ) => Material(child: SignupPage()),
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
  ),
));