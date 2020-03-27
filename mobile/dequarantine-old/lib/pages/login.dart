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
  //required variables/objects
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
    setState(() {
      isLoading = true;
    });

    //load locally stored instances
    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await _googleSignIn.isSignedIn();

    //if already signed in skip login page
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }

    setState(() {
      isLoading = false;
    });
  }

  //runs when user  presses sign in with google
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


    //create new document
    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("user")
          .where("uid", isEqualTo: firebaseUser.uid)
          .getDocuments();
      
      List<DocumentSnapshot> document = result.documents;

      //assign user attributes to document
      if (document.length == 0) {
        Firestore.instance.collection("user").document(firebaseUser.uid).setData({
          "uid": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "photoUrl" : firebaseUser.photoUrl,
        });

        //save user data locally
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

  Future name() async {
    var name;
    await _handleSignIn().then( (value) {
      value.displayName;
    });
    return name;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).buttonColor,
            ]
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Dequarantine", style: Theme.of(context).textTheme.headline2),
                Text("Sign in to continue")
              ],
            ),
            GoogleSignInButton(
              onPressed: () => _handleSignIn(),
            ),
          ],
        ),
      )
    );
  }
}

