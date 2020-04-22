import 'package:dequarantine/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signOut(BuildContext context) async {
  Fluttertoast.showToast(msg: "Signing you out");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  currentUser.clean();
  Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
}