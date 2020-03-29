import 'dart:core';

class EventCreation{
  final String cap;
  final String category;
  final String description;
  final String imageUrl;
  final String name;
  final String organizer;
  final String time;

  //TODO: find event post url
  final String _baseCreateEventUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/event";

  EventCreation(
    this.cap,
    this.category,
    this.description,
    this.imageUrl,
    this.name,
    this.organizer,
    this.time,
  );


  Future<bool> postEvent() async {
    Map body = {
      "name": name,
      "cap": cap,
      "category": category,
      "description": description,
      "imageUrl": imageUrl   
    };
  }

  // const newEvent = {
  //     name: req.body.name,
  //     cap:req.body.cap,
  //     category:req.body.category,
  //     organizer,
  //     description:req.body.description,
  //     time:new Date().toISOString(),
  //     imageUrl:req.body.imageUrl      
  // };
}