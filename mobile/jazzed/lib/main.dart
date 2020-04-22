import 'package:flutter/material.dart';
import 'package:jazzed/backend/auth/user/user.dart';
import 'package:jazzed/frontend/login/login_splash_screen.dart';
import 'package:jazzed/theme.dart';

import 'frontend/app/home.dart';
import 'frontend/entry/entry_point.dart';
import 'frontend/login/login.dart';
import 'frontend/signup/signup.dart';

CustomTheme theme = CustomTheme();
User currentUser;

void main() {
  runApp(MaterialApp(
    initialRoute: '/entry',
    routes: {
      '/entry': (context) => Material(child: EntryPoint()),
      '/login': (context) => Material(child: Login()),
      '/signup': (context) => Material(child: SignUp()),
      '/splashLogin': (context) => LoginSplashScreen(),
      '/home': (context) => Material(child: Home()),
    },
  ));
}
