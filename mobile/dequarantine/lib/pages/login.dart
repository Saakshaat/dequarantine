import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isLoading = false;
  bool isLoggedIn = false;

  SharedPreferences prefs;

  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignIn();
  }

  isSignIn() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await _googleSignIn.isSignedIn();

    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googelUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googelUser.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser firebaseUser =
        (await _firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("user")
          .where("uid", isEqualTo: firebaseUser.uid)
          .getDocuments();
      
      List<DocumentSnapshot> document = result.documents;

      if (document.length == 0) {
        Firestore.instance.collection("user").document(firebaseUser.uid).setData({
          "uid": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "photoUrl" : firebaseUser.photoUrl,
        });

        //DATA to local
        currentUser = firebaseUser;
        await prefs.setString("uid", currentUser.uid);
        await prefs.setString("username", currentUser.displayName);
        await prefs.setString("photoUrl", currentUser.photoUrl);
      } else {
        await prefs.setString("uid", document[0]["uid"]);
        await prefs.setString("username", document[0]["username"]);
        await prefs.setString("photoUrl", document[0]["photoUrl"]);
      }
      Fluttertoast.showToast(
        msg: "Sign in successful"
      );
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => Home()
      ));

    } else {
      Fluttertoast.showToast(
        msg: "Sign in unsuccessful"
      );
      setState(() {
        isLoading = false;
      });
    }
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("sign in"),
          onPressed: () => _handleSignIn(),
        ),
      )
    );
  }
}
