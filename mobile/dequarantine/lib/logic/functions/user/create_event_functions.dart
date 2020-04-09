import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


Future<bool> createEvent(Map body, String token) async {
  String eventUrl = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events";
  http.Response event = await http.post(eventUrl,
    headers: {"Authorization": "Bearer $token"},
    body: body
  );

  var response = convert.jsonDecode(event.body);
  print(response);

  print(event.statusCode.toString().substring(0,1));

  if (event.statusCode.toString().substring(0,1) == "2") {
    return true;
  }
  return false;
}