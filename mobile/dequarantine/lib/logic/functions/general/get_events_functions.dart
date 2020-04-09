import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


Future<Map<String, dynamic>> getAllEvents() async {
  String _eventUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events";

  http.Response events = await http.get(_eventUrl);

  Map<String, dynamic> response = {"body": convert.jsonDecode(events.body)};

  Map categories = {};

  convert.jsonDecode(events.body).forEach((event) {
    if (categories.containsKey(event["category"])) {
      categories[event["category"]].add(event);
    } else {
      categories[event["category"]] = [event];
    }
  });

  if (events.statusCode == 200) {
    response["code"] = true;
    return response;
  }

  print("error on getEvents");
  print("----> $response");
  response["code"] = false;
  return response;
}


Future<Map> getEventsByCategories() async {
  String _eventUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events";

  http.Response events = await http.get(_eventUrl);

  Map categories = {};

  if (events.statusCode == 200) {

    convert.jsonDecode(events.body).forEach((event) {
      if (categories.containsKey(event["category"])) {
        categories[event["category"]].add(event);
      } else {
        categories[event["category"]] = [event];
      }
    });

    categories["code"] = true;
    return categories;
  }

  print("error on getEvents");
  categories["code"] = false;
  return categories;
}