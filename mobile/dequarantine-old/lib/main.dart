import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/pages/login.dart';
import 'package:flutter/material.dart';

var fireStoreReference = Firestore.instance;


void main() {
  runApp(MaterialApp(
    home: Material(
      child: LoginPage()
    ),
    theme: ThemeData(
      primaryColor: Color.fromRGBO(	105, 240, 174, 1),
      buttonColor: Color.fromRGBO(63, 81, 181, 1),
      backgroundColor: Colors.white60,
      textTheme: TextTheme(
        headline2: TextStyle(
          color: Colors.black,
          fontSize: 50
        )
      )
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Colors.black87,
      primaryColor: Color.fromRGBO(43, 189, 126, 1),
      buttonColor: Color.fromRGBO(0, 41, 132, 1),
    ),
  ));
}

