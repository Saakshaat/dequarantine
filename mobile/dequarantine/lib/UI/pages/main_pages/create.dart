import 'package:dequarantine/UI/pages/logins/login_page.dart';
import 'package:dequarantine/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  String _titleString = "";
  String _description = "";
  String _category = "Professional";

  String _dropDownValueCategory = "Professional";

  DateTime start;
  DateTime end;

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: Text(text, style: Theme.of(context).textTheme.headline2),
    );
  }

  _onSubmit() {
    print("submit here");
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }


  Future<Null> handleSignOut() async {
    // this.setState(() {
    //   isLoading = true;
    // });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    // this.setState(() {
    //   isLoading = false;
    // });
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: _title("Event title"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Tell us what your event is about",
            ),
            expands: false,
            minLines: 1,
            maxLines: 9,
            controller: _titleController,
            onEditingComplete: () {
              _titleString = _titleController.text;
            },
          ),
        ),
       
        _title("Event description"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText:
                  "Tell us who you event is for and what will participants get out of it",
            ),
            expands: false,
            minLines: 1,
            maxLines: 9,
            controller: _descriptionController,
            onEditingComplete: () {
              _description = _descriptionController.text;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("Event Topics"),

            DropdownButton(
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: "Professional",
                  child: Text("Professional"),
                ),
                DropdownMenuItem(
                  value: "Entertainment",
                  child: Text("Entertainment"),
                ),
                DropdownMenuItem(
                  value: "Gaming",
                  child: Text("Gaming"),
                ),
                DropdownMenuItem(
                  value: "Sports",
                  child: Text("Sports"),
                ),
                DropdownMenuItem(
                  value: "Educational",
                  child: Text("Educational"),
                ),
              ],
              value: _dropDownValueCategory,
              onChanged: (String value) {
                setState(() {
                  _dropDownValueCategory = value;
                });
              })
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: OutlineButton(
            child: Text("Make it live!"),
            onPressed: () => _onSubmit,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: OutlineButton(
            child: Text("Log out!"),
            onPressed: () => handleSignOut(),
          ),
        ),
      ],
    );
  }
}
