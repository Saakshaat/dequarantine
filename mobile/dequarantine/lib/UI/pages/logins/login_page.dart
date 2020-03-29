import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/UI/pages/main_pages/home_page.dart';
import 'package:dequarantine/UI/widgets/logins/outline_button.dart';
import 'package:dequarantine/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
          
class _LoginPageState extends State<LoginPage> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //keep track of progress
  bool isLoading = false;
  bool isLoggedIn = false;

  //used to save locally device instance
  SharedPreferences prefs;

  //represents data of current user
  FirebaseUser currentUser;

  //runs on the first instance of the widget
  @override
  void initState() {
    super.initState();
    isSignIn();
  }


  //checks wether user is already logged in
  isSignIn() async {
    //load locally stored instances
    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await _googleSignIn.isSignedIn();

    //if already signed in skip login page
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }

  }

  //runs when user  presses sign in with google
  Future<void> _handleSignIn() async {
    //create reauired consts used to sign in with firebase,

    //grabs general user data from Google pop up
    final GoogleSignInAccount googelUser = await _googleSignIn.signIn();

    //keeps the auth data
    final GoogleSignInAuthentication googleAuth = await googelUser.authentication;

    //create firebase cretentials, using given auth account
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    String _baseGoogleUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin";

    Map body = {
      "id_token": googleAuth.idToken,
      "accessToken": googleAuth.idToken,
    };

    var a = await http.post(_baseGoogleUrl,
      body: body
    );

    var response = convert.jsonDecode(a.body);

    print(response);
  }
    
    //sign in with firebase credentials
    // final FirebaseUser firebaseUser = (await _firebaseAuth.signInWithCredential(credential)) .user;


    // //if user exists, can have just been created or pre existing, meaning sign in success
    // if (firebaseUser != null) {
    //   Fluttertoast.showToast(
    //     msg: "Sign in successful"
    //   );
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (context) => Home()
    //   ));
    // } else {
    //   Fluttertoast.showToast(
    //     msg: "Sign in unsuccessful"
    //   );
    // }
    // return firebaseUser;
  // }

  @override
  Widget build(BuildContext context) {
    double paddingVertical = MediaQuery.of(context).size.height * 0.10;
    double paddingHorizontal = MediaQuery.of(context).size.width * 0.15;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(child: Text("Dequarantine", style: Theme.of(context).textTheme.headline1,)),

          Text("Find online events that rejuvenate you.", style: Theme.of(context).textTheme.bodyText1,),

          Text("Connect to your community and wellbeing during Quarantine.", style: Theme.of(context).textTheme.bodyText1,),

          OutlineButtonLandingPage(
            text: "Sign in with email",
            route: "/email",
            pop: true,
          ),


          // OutlineButton(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: <Widget>[
          //       Icon(LineIcons.google),
          //       Text("Sign in with Google")
          //     ],
          //   ),
          //   onPressed: () async {
          //     bool loggedIn = await login.googleLogin();
          //     if (loggedIn) {
          //       Navigator.pushReplacementNamed(
          //         context,
          //         "/home",
          //       );
          //     }
          //   },
          // ),

          // GoogleSignInButton(
          //   onPressed: () => _handleSignIn(),
          // ),

          OutlineButtonLandingPage(
            text: "Continue without signing in",
            route: "/home",
            pop: false
          ),
        ],
      ),
    );
  }
}