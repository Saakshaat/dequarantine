import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';


void openUrl(String url, BuildContext context) async {
  print(url);
  try {
    await launch(url);
  } catch (e){ 
    Fluttertoast.showToast(msg: "Could not open url");
  }
}