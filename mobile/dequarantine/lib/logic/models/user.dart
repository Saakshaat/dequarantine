import 'dart:convert' as convert;
import 'dart:core';

import 'package:dequarantine/main.dart';
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

    switch (userDetail.statusCode) {
      case 200:
        Map body = convert.jsonDecode(userDetail.body);
        body["code"] = true;
        return body;
        break;

      default:
        return {"code": false};
    }
  }

  String getToken() {
    return _token;
  }

  void clean(){
    this._token = null;
    this._userId = null;
    this._email = null;
    this._imageUrl = null;
    this._userName = null;
    currentUser = null;
  }


  Future<String> getImageUrl() async {
    //TODO
    http.Response getRequest = await http.get(_imageUrl,
      headers: {
        "Authorization": "Bearer $_token"
      }
    );

    if (getRequest.statusCode == 200) {
      String image = getRequest.body;
      print(image); 
    }
  }


  Future<Map<String, dynamic>> getLikedEvents() async {
    //TODO: ask Saak on how to
  }
}