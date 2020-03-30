import 'package:dequarantine/constants.dart';
import 'package:dequarantine/models/google_user.dart';
import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


class UserManagement {
  bool isLogginIn = false;

  String _baseGoogleUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin";
  String _baseSignInEmailUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/login";
  String _baseSignUpEmailUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/signup";

  Future<bool> googleLogin() async {
   
      var _signInDetails = await googleSignIn.signIn();
      var _authDetails = _signInDetails.authentication;
      
      Map accessCodes = {};

      await _authDetails.then((value) {
        accessCodes["idToken"] = value.idToken;
        accessCodes["accessToken"] = value.accessToken;
      });

      Map user = {
        "uid": _signInDetails.id,
        "displayName": _signInDetails.displayName,
        "photoUrl": _signInDetails.photoUrl,
        "email": _signInDetails.email,
        "accessToken": accessCodes["accessToken"],
        "idToken": accessCodes["idToken"],
      };
      
      currentUser = GoogleUser(user);
      currentUser.printData();

      var api = await signInGoogleToApi();
      print(api);
      if (api){
        return true;
      }
      return false;
    
  }



  //Clean user data and disconnect google log in
  void signOut() {
    isLogginIn = false;
    currentUser.clean();
    googleSignIn.signOut();
    googleSignIn.disconnect();
  }


  Future<Map<String, dynamic>> signUpEmail(String username, String email, String pass1, String pass2) async {
    var a = await http.post(_baseSignUpEmailUrl,
      body: {
        "email": email,
        "password": pass1,
        "confirmPassword": pass2,
        "userName": username
      }
    );

    var response = convert.jsonDecode(a.body);
    print(response);

    print(a.statusCode);

    if (a.statusCode == 201) {
      return {"code": true, "body": response};
    }
    return {"code": false, "body": response};
  }


  Future<bool> signInEmailToApi() async {
    var attributes =  currentUser.get();
    var a = await http.post(
      _baseSignInEmailUrl,
      body: {
        "email": attributes["email"],
        "password": attributes["password"],
      }
    );

    var response = convert.jsonDecode(a.body);

    print(response);

    print(a.statusCode);
    if (a.statusCode == 200) {
      print("sign in successfull");

      currentUser.setToken(response["token"]);

      return true;
    }
    return false;
  }

  Future<bool> signInGoogleToApi() async {
    Map attributes = currentUser.get();

    var a = await http.post(
      _baseGoogleUrl,
      body: {
        "userName": attributes["name"],
        "email": attributes["email"],
        "imageUrl": attributes["imageUrl"],
        "userId": attributes["uid"]
      }
    );

    var response = convert.jsonDecode(a.body);

    print(a.statusCode);

    print(response);

    if (a.statusCode == 200) {
      print("sign in successfull");
      return true;
    }
    return false;
  }
}