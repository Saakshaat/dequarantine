import 'package:dequarantine/constants.dart';
import 'package:dequarantine/models/user.dart';

import 'package:http/http.dart' as http;


class UserManagement {
  bool isLogginIn = false;

  String _baseGoogleUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/g/signin";

  Future<bool> googleLogin() async {
    try {
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
      
      currentUser = User(user);
      currentUser.printData();
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }


  //Clean user data and disconnect google log in
  void signOut() {
    isLogginIn = false;
    currentUser.clean();
    googleSignIn.signOut();
    googleSignIn.disconnect();
  }

  void sendToApi() {
    //TODO: post user data to backend and await response
    http.post(_baseGoogleUrl);
  }
}