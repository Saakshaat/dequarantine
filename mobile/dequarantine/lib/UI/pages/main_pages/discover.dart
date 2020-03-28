import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/UI/widgets/events/staggered_view.dart';
import 'package:dequarantine/constants.dart';
import 'package:flutter/material.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  // List items = List<String>.generate(20, (index) => "item $index");
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder(
        stream: fireStoreReference.collection("events").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Could not load events"),
            );
          }

          if (snapshot.hasData) {
            List events = [];
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["name"].toString(),
                "tag": element["category"].toString(),
                "time": element["time"].toString(),
                "description": element["Description"].toString()
              });
            });
            for (int i = 0; i < 5; ++i){
              events += events;
            }

            return Events(events: events, length: events.length);
          }

          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}