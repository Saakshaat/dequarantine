import 'dart:convert' as convert;
import 'dart:core';

import 'package:dequarantine/logic/models/user.dart';
import 'package:dequarantine/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

Future<Map> signInWithEmail(String email, String password) async {
  String _baseSignInEmailUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/login";

  http.Response signIn  = await http.post(
    _baseSignInEmailUrl,
    body: {
      "email": email,
      "password": password,
    }
  );

  Map response = convert.jsonDecode(signIn.body);

  switch (signIn.statusCode) {
    case 200:
      print("Sign in successful");

      String userToken = response["token"];

      String _baseUserUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";

      print("Token: $userToken");

      http.Response userData  = await http.get(
        _baseUserUrl,
        headers: {
          "Authorization" : "Bearer $userToken"
        }
      );

      Map response2 = convert.jsonDecode(userData.body);

      print(response);

      currentUser = User({
        "token": userToken,
        "userId": response2["credentials"]["userId"],
        "email": response2["credentials"]["email"],
        "imageUrl": response2["credentials"]["imageUrl"],
        "userName": response2["credentials"]["userName"],
      });

      return {"code": true, "body": response};
      break;
    default:
      print("Sign in unsuccessful");
      return {"code": false, "body": response};
  }
}








Future<void> handleSignInGoogle() async {
  //create reauired consts used to sign in with firebase,
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //grabs general user data from Google pop up
  final GoogleSignInAccount googelUser = await _googleSignIn.signIn();

  //keeps the auth data
  final GoogleSignInAuthentication googleAuth = await googelUser.authentication;

  print("ID token: ${googleAuth.idToken}");
  print("Access token: ${googleAuth.accessToken}");

  //create firebase cretentials, using given auth account
  // AuthCredential credential = GoogleAuthProvider.getCredential(
  //   accessToken: googleAuth.accessToken,
  //   idToken: googleAuth.idToken,
  // );


  String _baseGoogleUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin";

  Map body = {
    "accessToken": googleAuth.accessToken,
  };

  var a = await http.post(_baseGoogleUrl,
    body: body
  );

  var response = convert.jsonDecode(a.body);

  print(response);
}


