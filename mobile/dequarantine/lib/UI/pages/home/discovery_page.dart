import 'package:dequarantine/UI/widgets/events/events_view.dart';
import 'package:dequarantine/logic/functions/general/get_events_functions.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';

class DiscoverPageOld extends StatefulWidget {
  @override
  _DiscoverPageOldState createState() => _DiscoverPageOldState();
}

class _DiscoverPageOldState extends State<DiscoverPageOld> {
  String _username = "";
  String _greeting = "";

  @override
  void initState() {
    super.initState();
    print("first state");
    try {
      _username = currentUser.getUserName()[0].toUpperCase() +
          currentUser.getUserName().substring(1);
      int now = DateTime.now().hour;
      _greeting = _timeGreeting(now);

    } catch (e) {
      _greeting = _timeGreeting(DateTime.now().hour);
    }
  }

  String _timeGreeting(int hour) {
    String greeting = "";

    if (0 <= hour && hour < 6)
      greeting = "night";
    else if (6 <= hour && hour < 12)
      greeting = "morning";
    else if (12 <= hour && hour < 18)
      greeting = "afternoon";
    else if (18 <= hour && hour < 23)
      greeting = "evening";
    else
      return "Hello";

    return "Good " + greeting;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 3,
          title: Text("$_greeting $_username"),
        ),
        body: FutureBuilder(
          future: getAllEvents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List eventsList = snapshot.data["body"];

              return Events(
                events: eventsList,
                length: eventsList.length,
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
