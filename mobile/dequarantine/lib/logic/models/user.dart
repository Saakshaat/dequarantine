import 'dart:convert' as convert;
import 'dart:core';

import 'package:dequarantine/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class User {
  String _token;
  String _userId;
  
  String _email;
  String _imageUrl;
  String _userName;

  Map _userDataFB = {};


  User(user) {
    this._token = user["token"];
    this._userId = user["userId"];
    this._email = user["email"];
    this._imageUrl = user["imageUrl"];
    this._userName = user["userName"];
  }


  String getUserName() {
    return _userDataFB["credentials"]["userName"];
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
        _userDataFB = convert.jsonDecode(userDetail.body);
        
        _userDataFB["code"] = true;
        
        return _userDataFB;
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

  Future<bool> markAttending(String eventId, BuildContext context) async {
    print(eventId);

    String url = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events/markAttended/$eventId";

    http.Response marked = await http.get(url,
      headers: {
        "Authorization": "Bearer $_token"
      }
    );

    //409 for already marked attending
    print(marked.statusCode);

    if (marked.statusCode == 200) {
      Fluttertoast.showToast(msg: "Marked as attended");
    } else if (marked.statusCode == 409) {
      Fluttertoast.showToast(msg: "Already attending");
    }
  }

  Future<void> markUnattending(String eventId) async {
    print(eventId);

    String url = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events/unmarkAttended/$eventId";

    http.Response marked = await http.get(url,
      headers: {
        "Authorization": "Bearer $_token"
      }
    );

    print(marked.statusCode);
  }

  Future<List> getAttendingEvents() async {
    String url = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user/attending";

    http.Response markedAttending = await http.get(url,
      headers: {
        "Authorization": "Bearer $_token"
      }
    );

    if (markedAttending.statusCode == 200) {
      List response = convert.jsonDecode(markedAttending.body);
      return response;
    } else {
      return [];
    }
  }
}



