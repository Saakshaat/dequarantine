import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transition_test/new_page.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blueGrey,
          child: Center(
            child: FlatButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Material(child: NewPage()))),
              child: Text("Tap to transition"),
            ),
          ),
        ),
      ),
    );
  }
}
