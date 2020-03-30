import 'package:dequarantine/UI/widgets/events/staggered_view.dart';
import 'package:dequarantine/logic/functions/get_events_functions.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}