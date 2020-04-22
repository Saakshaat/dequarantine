import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart';
import 'package:jazzed/backend/auth/user/user.dart';
import 'package:jazzed/main.dart';

class EmailSignUp with ChangeNotifier {
  TextEditingController usernameController = TextEditingController();
  TextEditingController email1Controller = TextEditingController();
  TextEditingController email2Controller = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  String _signUpEndPoint =
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/signup";

  String _userDataEndPoint =
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";

  bool success = false;

  String error = "";

  Future<Response> postCredentials() async {
    Response signUp = await post(_signUpEndPoint, body: {
      "userName": usernameController.text,
      "email": email1Controller.text,
      "password": password1Controller.text,
      "confirmPassword": password2Controller.text,
    });

    return signUp;
  }

  void signUp() async {
    if (email1Controller.text != email2Controller.text) {
      error = "Emails don't match";
      notifyListeners();
    } else if (password1Controller.text != password2Controller.text) {
      error = "Password don't match";
      notifyListeners();
    } else if (email1Controller.text == email2Controller.text &&
        password1Controller.text == password2Controller.text) {
      Response signUp = await postCredentials();

      Map<String, dynamic> signUpResponse = Map.from(jsonDecode(signUp.body));

      print(signUp.statusCode);

      switch (signUp.statusCode) {
        case 201:
          String authToken = signUpResponse["token"];

          Response userDataGet = await get(_userDataEndPoint,
              headers: {"Authorization": "Bearer $authToken"});

          Map<String, dynamic> userData =
              Map.from(jsonDecode(userDataGet.body));

          currentUser = User.fromJson(userData);
          success = true;
          break;

        case 400:
          error = signUpResponse[signUpResponse.keys.toList()[0]];

          break;

        case 500:
          error = "We made an error somewhere, please try again later";
          break;

        default:
          error = "idk dude";
          break;
      }
      notifyListeners();
    } else {
      error = "Unexpected error, please try again";
      notifyListeners();
    }
  }
}
