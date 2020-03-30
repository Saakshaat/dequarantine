import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> signUpEmail(String username, String email, String pass1, String pass2) async {
    String _baseSignUpEmailUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/signup";
    
    var signUp = await http.post(_baseSignUpEmailUrl,
      body: {
        "userName": username,
        "email": email,
        "password": pass1,
        "confirmPassword": pass2,
      }
    );

    var response = convert.jsonDecode(signUp.body);

    switch (signUp.statusCode) {
      case (201):
        print("Sign up successful");
        return {"code": true, "body": response};
        break;

      default:
        return {"code": false, "body": response};
    }
  }