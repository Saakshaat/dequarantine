import 'package:DribbleUI/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      primaryColor: Color.fromARGB(255, 89, 73, 192),
      // accentColor: Color.fromRGBO(, opacity)
      textTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 35
        ),
        headline2: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 25
        ),
        bodyText1: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.w300,
          fontSize: 15,
        ),
      )
    ),
  ));
}