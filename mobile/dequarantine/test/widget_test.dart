import 'package:test/test.dart';
import 'dart:convert' as convert;
import 'dart:core';

import 'package:http/http.dart' as http;


Future markAttending(String eventId) async {
  String url = "https://us-central1-dequarantine-aae5f.cloudfunctions.net/baseapi/events/markAttended/$eventId";
  String _token = "eyJhbGciOiJSUzI1NiIsImtpZCI6ImRjMGMzNWZlYjBjODIzYjQyNzdkZDBhYjIwNDQzMDY5ZGYzMGZkZWEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZGVxdWFyYW50aW5lLWFhZTVmIiwiYXVkIjoiZGVxdWFyYW50aW5lLWFhZTVmIiwiYXV0aF90aW1lIjoxNTg2NjE0NzMxLCJ1c2VyX2lkIjoiRVZ5TVVRWDcxYlc3bHlURFFYWUVRZ2dlZ2I3MyIsInN1YiI6IkVWeU1VUVg3MWJXN2x5VERRWFlFUWdnZWdiNzMiLCJpYXQiOjE1ODY2MTQ3MzEsImV4cCI6MTU4NjYxODMzMSwiZW1haWwiOiJwQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJwQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.BnGHHNbbuRyRe1b8yk5vTPMpAyUcwgRZGYeIigC0mthfx-I6eORRKKAuGs4Bu13nA0UC6tKH0Io9luO89avymNI2UNMU4rpmmn8mdWerU94izgrvuzo1AaFMiDaam-KgQTf6fuezY-VQjK32zOyhxthJgVdzUbTFYsL-DRDxGf3VMmiPZOJFFaL8f39saKCoIUPYkVp46EATgD5TybBb3y15W92-l5P5_Y63EZH6MeQLkpT0ZATB8HfZvRb930Tn5XpknckFwdS8FzOjE69VJz-XxOG-oy_3B4BllCj9ON-B2Eb-iXXRmuWmHifSVm-ItOjYSRWmB9uaxWqUCjlGvg";

  Map<String, String> headers = {
    "Authorization": "Bearer $_token",
    "ClientSecret": "wTmD8HiXIXM0z77KiC5Kz3ot",
    "CliendID": "828379572147-fq36c6ct551l1llcv3v79j0er417gcgi.apps.googleusercontent.com",
    "RedirectURI": "urn:ietf:wg:oauth:2.0:oob",
  };

  http.Response markAttendedResponse = await http.get(url, headers: headers);

  Map resp = Map<String, String>.from(convert.json.decode(markAttendedResponse.body));

  return resp ;
}

main() async {
  // test('Testing time function', () {
  //   var expected = "Good morning";

  //   var acual = _timeGreeting(6);
  //   expect(acual, expected);
  // });
  test("Testing markAttended", () async {
    Map<String, String> expected = {
      "general": "Already attending this event",
      "url": "https://accounts.google.com/o/oauth2/v2/auth?access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.events&response_type=code&client_id=828379572147-fq36c6ct551l1llcv3v79j0er417gcgi.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob"
    };

    Map<String, String> actual = await markAttending("i2QA47mrCbU3PDe2HBQC");


    expect(actual, expected);
  });
}