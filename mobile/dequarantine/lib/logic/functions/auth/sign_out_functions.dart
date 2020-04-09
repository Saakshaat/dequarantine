import 'package:dequarantine/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

void signOut(BuildContext context) {
  Fluttertoast.showToast(msg: "Signing you out");
  currentUser.clean();
  Navigator.pushNamedAndRemoveUntil(context, "/login", (Route<dynamic> route) => false);
}