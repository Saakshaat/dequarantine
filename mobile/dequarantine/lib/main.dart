import 'package:dequarantine/UI/pages/home_page.dart';
import 'package:dequarantine/UI/pages/logins/email_page.dart';
import 'package:dequarantine/UI/pages/logins/login_page.dart';
import 'package:flutter/material.dart';



void main() => runApp(MaterialApp(
  initialRoute: "/login",
  routes: {
    "/home" : ( context ) => Material(child: Home()),
    "/login" : ( context ) => Material(child: LoginPage()),
    "/email" : ( context ) => Material(child: EmailPage()),
  },
));