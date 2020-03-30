import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String username = "currentUser";

  bool activeUser = false;

  Future<String> getUserDetails() async {
    String name = "";
    Future.delayed(Duration(seconds: 1), () {
      name = "Germain Leignel";
    });

    return name;
  }

  // void _signOut() {
  //   currentUser.signOut();
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     Navigator.pushNamedAndRemoveUntil(
  //         context, "/login", (Route<dynamic> route) => false);
  //   });
  // }

  TextStyle _numTextStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600);

  Map userData  ={"email" : "testing@gmail.com"};

  void getUserDetail() async {
    http.Response userDetail = await http.get(
        "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/user",
        headers: {
          "Authorization":
              "Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjgzYTczOGUyMWI5MWNlMjRmNDM0ODBmZTZmZWU0MjU4Yzg0ZGI0YzUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGVxdWFyYW50aW5lLWFhZTVmIiwiYXVkIjoiZGVxdWFyYW50aW5lLWFhZTVmIiwiYXV0aF90aW1lIjoxNTg1NTIxMzcwLCJ1c2VyX2lkIjoiaVRvNjFEUERIR2RKbjNHaVMzOUdJaHZhTTBvMSIsInN1YiI6ImlUbzYxRFBESEdkSm4zR2lTMzlHSWh2YU0wbzEiLCJpYXQiOjE1ODU1MjEzNzAsImV4cCI6MTU4NTUyNDk3MCwiZW1haWwiOiJnZXJtYWluLmxlaWduZWxAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbImdlcm1haW4ubGVpZ25lbEBnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.GpM3HqRmpj78XAPtLN6V8umwdcqDUmwsIiRZgo2IuG5_juLE70aySn6-ELibnzYU5Ma2sOwTMdxK4xqj_vpAgmqKGlCzn9JN-L6poK8DgZBWS4_3bQdo0lzbqpBw5la71qa5sf24k0WTESHUnRFBypgXH6P91LmwtnooZmsKoptrEaBAlkkjWVSF-QN0TA3My350kRBSxDqKCXDuBE1FBu5mhLfTt6_DUnq4u3HOqHPNp65HEGOmdJMvEUqTbpLY7nScpkPGuDUypC4SR0_vgsfjN1bGjANU7PNv4Yuahguyn-16B2anAbXZlwS_m4V697J9tX-dOgUQVvU-hUkSkA"
        });

    print("usr detail: ${convert.jsonDecode(userDetail.body)}");
  }

  @override
  Widget build(BuildContext context) {
    // try {
    //   userData = currentUser.get();
    //   // print(userData);
    //   getUserDetail();
    //   setState(() {
    //     activeUser = true;
    //   });
    // } catch (e) {
    //   if (e == NoSuchMethodError) {
    //     setState(() {
    //       activeUser = false;
    //     });
    //   }
    // }

    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://vignette.wikia.nocookie.net/gtawiki/images/7/70/CJ-GTASA.png/revision/latest/top-crop/width/360/height/360?cb=20190612091918"),
              child: Text("GL"),
              foregroundColor: Colors.transparent,
              minRadius: MediaQuery.of(context).size.width / 8,
              maxRadius: MediaQuery.of(context).size.width / 8,
            ),
            Text(
              "Germain Leignel",
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              userData["email"],
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "6",
                      style: _numTextStyle,
                    ),
                    Text(
                      "Past events",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "8",
                      style: _numTextStyle,
                    ),
                    Text("Upcoming events"),
                  ],
                ),
              ],
            ),
            Text("Settings"),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Theme.of(context).buttonColor,
              child: Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => null,
            )
          ],
        );

  }
}
