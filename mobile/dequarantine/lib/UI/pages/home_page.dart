
import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List data = currentUser.get();
    return ListView.builder(
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      itemCount: data.length +1 ,
      itemBuilder: (BuildContext context, int index) {
        if (index == data.length ) {
          return FlatButton(
            child: Text("sign out"),
            onPressed: () {
              login.signOut();
              SchedulerBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(
                  context,
                  "/login"
                );
              });
            },
          );
        }
        return Text(data[index]);
      }
    );
  }
}