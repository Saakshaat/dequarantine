import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dequarantine/UI/widgets/events/staggered_view.dart';
import 'package:dequarantine/constants.dart';
import 'package:dequarantine/main.dart';
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
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            snapshot.data.documents.forEach((element) {
              events.add({
                "title": element["title"].toString(),
                "tag": fireStoreReference.collection("category").document("${element["tags"][0]}").toString(),
                "time": element["time"].toString(),
                "description": element["description"]
              });
            });
            return Events(events: events);
          }

          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}