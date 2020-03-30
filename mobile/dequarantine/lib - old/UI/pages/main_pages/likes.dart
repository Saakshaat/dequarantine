import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';


class Likes extends StatefulWidget {
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  bool activeUser = false;

  @override
  Widget build(BuildContext context) {
    try {
      currentUser.printData();
    } catch (e) {
      if (e == NoSuchMethodError) {
        setState(() {
          activeUser = false;
        });
      }
    }
    return activeUser ? Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Liked events pages"),
            Text("currently signed in : ${currentUser.get()["email"]}")
          ],
        ),
      ) 
    ) : Container(
      child: Center(child: Text("Sign in to access liked events :)")),
    );
  }
}