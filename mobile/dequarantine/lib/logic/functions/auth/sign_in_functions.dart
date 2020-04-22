import 'dart:convert' as convert;
import 'dart:core';

import 'package:dequarantine/logic/functions/auth/shared_prefs.dart';
import 'package:dequarantine/logic/models/user.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

Future<Map> signInWithEmail(String email, String password) async {
  String _baseSignInEmailUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/login";

  // Map body = Map<String, String>();
  // body["email"] = email;
  // body["password"] = password;

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

      writeToShared("email", email);
      writeToShared("password", password);

      String userToken = response["token"];

      String userDataUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";

      print("Token: $userToken");

      http.Response userData  = await http.get(
        userDataUrl,
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

      if ((await currentUser.getAccountData())["code"] == true) {
        return {"code": true, "body": response};
      }

      break;
  }
  print("Sign in unsuccessful");

  List temp = [];
  response.map((key, value) {
    temp.add(value);
  });

  String error = temp[0];
  
  return {"code": false, "body": error};
}





Future<Map<String, dynamic>> handleSignInGoogle(BuildContext context) async {
  try{
    //create reauired consts used to sign in with firebase,
    final GoogleSignIn _googleSignIn = GoogleSignIn(
      // signInOption: SignInOption.standard,
      // clientId: "828379572147-fq36c6ct551l1llcv3v79j0er417gcgi.apps.googleusercontent.com",
      // hostedDomain: 
    );
    //grabs general user data from Google pop up
    final GoogleSignInAccount googelUser = await _googleSignIn.signIn();

    //keeps the auth data
    final GoogleSignInAuthentication googleAuth = await googelUser.authentication;

    


    // print("google_IdToken: ${googleAuth.idToken}");
    // print("google_Accesstoken: ${googleAuth.accessToken}");

    //create firebase cretentials, using given auth account
    // AuthCredential credential = GoogleAuthProvider.getCredential(
    //   accessToken: googleAuth.accessToken,
    //   idToken: googleAuth.idToken,
    // );


    String _baseGoogleUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin";


    Map body = {
      "access_token": googleAuth.accessToken,
      "id_token": googleAuth.idToken,
    };

    var postTokens = await http.post(_baseGoogleUrl,
      body: body
    );

    var responsePostToken = convert.jsonDecode(postTokens.body);

    if (postTokens.statusCode == 200 || postTokens.statusCode == 201) {
      String refreshToken = responsePostToken["refreshToken"];

      String getAccessTokenUrl = "https://securetoken.googleapis.com/v1/token?key=AIzaSyBd1r9PD9IRGs7-gdWoig-vjsvIZ2zpU5E";
      var postRefreshToken = await http.post(getAccessTokenUrl,
        body: {
          "refreshToken": refreshToken,
          "grant_type": "refresh_token",
        }
      );

      if (postRefreshToken.statusCode == 200) {

        Map userData = Map.from(convert.jsonDecode(postRefreshToken.body));

        String userDataUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";
        http.Response userDataResponse  = await http.get(
          userDataUrl,
          headers: {
            "Authorization" : "Bearer ${userData["access_token"]}"
          }
        );

        Map userDataFromFb = convert.jsonDecode(userDataResponse.body);

        currentUser = User({
          "token": userData["access_token"],
          "userId": userDataFromFb["credentials"]["userId"],
          "email": userDataFromFb["credentials"]["email"],
          "imageUrl": userDataFromFb["credentials"]["imageUrl"],
          "userName": userDataFromFb["credentials"]["userName"],
        });

        writeToShared("refreshToken", refreshToken);
        Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
      }
    }
    return Map.from({"code": false});

  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
}




void logInFromSavedEmail(context) async {
  String email = await readFromShared("email");
  String password = await readFromShared("password");

  var funcResponse = await signInWithEmail(email, password);

  Map<String, dynamic> resp = Map.from(funcResponse);

  bool code = resp["code"];
  if (code) {
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }
}

void logInFromSavedGoogle(BuildContext context) async {
  String refreshToken = await readFromShared("refreshToken");

  String getAccessTokenUrl = "https://securetoken.googleapis.com/v1/token?key=AIzaSyBd1r9PD9IRGs7-gdWoig-vjsvIZ2zpU5E";
  var postRefreshToken = await http.post(getAccessTokenUrl,
    body: {
      "refreshToken": refreshToken,
      "grant_type": "refresh_token",
    }
  );

  if (postRefreshToken.statusCode == 200) {

    Map userData = Map.from(convert.jsonDecode(postRefreshToken.body));

    String userDataUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";
    http.Response userDataResponse  = await http.get(
      userDataUrl,
      headers: {
        "Authorization" : "Bearer ${userData["access_token"]}"
      }
    );

    Map userDataFromFb = convert.jsonDecode(userDataResponse.body);

    currentUser = User({
      "token": userData["access_token"],
      "userId": userDataFromFb["credentials"]["userId"],
      "email": userDataFromFb["credentials"]["email"],
      "imageUrl": userDataFromFb["credentials"]["imageUrl"],
      "userName": userDataFromFb["credentials"]["userName"],
    });

    writeToShared("refreshToken", refreshToken);
    Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
  }
}