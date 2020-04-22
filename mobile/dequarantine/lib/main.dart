import 'package:dequarantine/UI/pages/home/home_page.dart';
import 'package:dequarantine/UI/pages/setup/login_splah.dart';
import 'package:dequarantine/UI/pages/setup/signin_page.dart';
import 'package:dequarantine/UI/pages/setup/signin_with_email_page.dart';
import 'package:dequarantine/UI/pages/setup/signup_page.dart';
import 'package:dequarantine/logic/models/user.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

User currentUser; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initalRoute = "/login";

  int mode = 0;
  bool checkEmail = prefs.containsKey('email');
  bool checkPassword = prefs.containsKey('password');
  bool checkGoogle = prefs.containsKey("refreshToken");

  if (checkEmail && checkPassword) {
    mode = 1;
    initalRoute = "/loginSplashScreen";
  } else if (checkGoogle) {
    mode = 1;
    initalRoute = "/loginSplashScreen";
  }


  runApp(
    MaterialApp(
      initialRoute: initalRoute,

      routes: {
        "/home" : ( context ) => Material(child: Home()),
        "/login" : ( context ) => Material(child: SignInPage()),
        "/email" : ( context ) => Material(child: SignInWithEmailPage()),
        "/signup" : ( context ) => Material(child: SignUpPage()),
        "/loginSplashScreen": ( context ) => Material(child: LoginSplash(mode: mode,)),
      },

      theme: ThemeData(
        primaryColor: Color.fromRGBO(	105, 240, 174, 1),
        buttonColor: Color.fromRGBO(63, 81, 181, 1),
        backgroundColor: Colors.grey[100],
          
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

          bodyText2: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w500
          ),
        )
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.blueGrey[900],
        primaryColor: Color.fromRGBO(43, 189, 126, 1),
        buttonColor: Color.fromRGBO(0, 81, 172, 1),

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

          bodyText2: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w500
          ),
        )
      ),
    )
  );
}

// ##3 categories
//  - career
//  - Mental health / mood
//  - move

// what are other people doing now ? ideas on what to do
// how are other people living now ?
//  - self care
//  - dating
//  - how are


// What we are doing:
//  - provide live streaming events for people to connect
//  - curation of things to do 