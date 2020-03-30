import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


class User {
  String _token;
  String _userId;
  
  String _email;
  String _imageUrl;
  String _userName;


  User(user) {
    this._token = user["token"];
    this._userId = user["userId"];
    this._email = user["email"];
    this._imageUrl = user["imageUrl"];
    this._userName = user["userName"];
  }


  Future<Map<String, dynamic>> getAccountData() async {
    http.Response userDetail = await http.get(
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user",
      headers: {
        "Authorization": "Bearer $_token"
      }
    );

    Map body = convert.jsonDecode(userDetail.body);
    body["code"] = userDetail.statusCode;

    switch (userDetail.statusCode) {
      case 200:
        body["code"] = true;
        return body;
        break;

      default:
        body["code"] = false;
        return body;
    }
  }

  String getToken() {
    return _token;
  }


  Future<Map<String, dynamic>> getLikedEvents() async {
    //TODO: ask Saak on how to
  }
}