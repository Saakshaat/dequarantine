import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:jazzed/backend/auth/user/user.dart';
import 'package:jazzed/main.dart';

class EmailSignIn with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String error = "";

  bool attempting = false;

  bool isLoggedIn = false;

  String _emailSignInEndPoint =
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/login";

  String _userDataEndPoint =
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user";

  void signIn() async {
    attempting = true;
    notifyListeners();

    Response signInPost = await post(_emailSignInEndPoint, body: {
      "email": emailController.text,
      "password": passwordController.text
    });

    Map jsonResponse = Map.from(jsonDecode(signInPost.body));

    print(jsonResponse);

    switch (signInPost.statusCode) {
      case 200:
        String authToken = jsonResponse["token"];

        Response userDataGet = await get(_userDataEndPoint,
            headers: {"Authorization": "Bearer $authToken"});

        Map<String, dynamic> userData = Map.from(jsonDecode(userDataGet.body));

        currentUser = User.fromJson(userData);

        print(currentUser.credentials.email);

        isLoggedIn = true;
        break;
      case 400:
        error = "Email must be valid";
        break;
      case 403:
        error = jsonResponse["general"];
        break;
      default:
        error = "Something unexpected went wrong";
        break;
    }
    attempting = false;
    notifyListeners();
  }
}
