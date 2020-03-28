import 'package:flutter/material.dart';


class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Live events here"),
      ),
    );
  }
}