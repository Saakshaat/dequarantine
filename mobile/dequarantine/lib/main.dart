import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/home.dart';
import 'package:flutter/material.dart';

var fireStoreReference = Firestore.instance;



void main() {
  runApp(MaterialApp(
    home: Home(),
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      accentColor: Colors.blueGrey,
    ),
  ));
}

