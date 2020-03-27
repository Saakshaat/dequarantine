import 'package:flutter/material.dart';

class Likes extends StatefulWidget {
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Liked events here"),
    );
  }
}