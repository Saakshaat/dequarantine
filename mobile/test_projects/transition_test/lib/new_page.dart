import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[400],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Cool transition"),
          SizedBox(height: 20,),
          Image.network("https://source.unsplash.com/600x300/?transition"),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Back"),
          )
        ],
      ),
    );
  }
}