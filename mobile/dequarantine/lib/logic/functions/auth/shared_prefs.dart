import 'package:shared_preferences/shared_preferences.dart';


Future writeToShared(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}


Future readFromShared(String key,) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String val = prefs.getString(key);
  return val;
}