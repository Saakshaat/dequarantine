import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';


class Likes extends StatefulWidget {
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    currentUser.printData();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Liked events pages"),
            Text("currently signed in : ${currentUser.get()["email"]}")
          ],
        ),
      ),
    );
  }
}