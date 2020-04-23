import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Montserrat",
  primaryColor: Color.fromRGBO(33, 150, 243, 1),
  accentColor: Color.fromRGBO(255, 193, 7, 1),
  dividerColor: Color.fromRGBO(189, 189, 189, 1),
  textTheme: TextTheme(
    headline2: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
    headline1: TextStyle(fontSize: 40, fontStyle: FontStyle.italic, color: Colors.black),
    headline3: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.black),
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Montserrat",
  primaryColor: Color.fromRGBO(25, 118, 210, 1),
  accentColor: Color.fromRGBO(255, 193, 7, 1),
  dividerColor: Color.fromRGBO(189, 189, 189, 1),
  textTheme: TextTheme(
    headline2: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    headline1: TextStyle(
        fontSize: 40, fontStyle: FontStyle.italic, color: Colors.white),
    headline3: TextStyle(
        fontSize: 30, fontStyle: FontStyle.italic, color: Colors.white),
  ),
);
