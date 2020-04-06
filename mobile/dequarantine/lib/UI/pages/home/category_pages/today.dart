import 'package:dequarantine/UI/widgets/events/events_view.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';



class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: currentUser.getAccountData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData){
          return Events(
            events: snapshot.data["attending"],
            length: snapshot.data["attending"].length,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}