import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:jazzed/backend/event/event.dart';
import 'package:http/http.dart';

class EventProvider with ChangeNotifier {
  List<Event> events = List<Event>();

  String eventEndPoint =
      "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events";

  bool success = false;
  bool attempting = false;

  void getEvents() async {
    attempting = true;
    notifyListeners();
    Response getEventsFromFB = await get(eventEndPoint);


    switch (getEventsFromFB.statusCode) {
      case 200:

        List<dynamic> jsonResponseEvents = jsonDecode(getEventsFromFB.body);

        jsonResponseEvents.forEach((element) {
          events.add(Event.fromJson(element));
        });

        success = true;
        notifyListeners();
    }
    attempting = false;
    notifyListeners();
  }
}
