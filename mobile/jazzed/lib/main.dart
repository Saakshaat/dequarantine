import 'package:flutter/material.dart';
import 'package:jazzed/backend/auth/user/user.dart';
import 'package:jazzed/frontend/login/login_splash_screen.dart';
import 'package:jazzed/theme.dart';

import 'package:jazzed/frontend/app/home.dart';
import 'package:jazzed/frontend/entry/entry_point.dart';
import 'package:jazzed/frontend/login/login.dart';
import 'package:jazzed/frontend/signup/signup.dart';

User currentUser;

void main() {
  runApp(MaterialApp(
    initialRoute: '/entry',
    theme: lightTheme,
//    darkTheme: darkTheme,
    routes: {
      '/entry': (context) => Material(child: EntryPoint()),
      '/login': (context) => Material(child: Login()),
      '/signup': (context) => Material(child: SignUp()),
      '/splashLogin': (context) => LoginSplashScreen(),
      '/home': (context) => Material(child: Home()),
    },
  ));
}
