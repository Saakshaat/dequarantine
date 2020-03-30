import 'package:dequarantine/UI/pages/logins/login_page.dart';
import 'package:dequarantine/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dequarantine/functions/create_event.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _capController;
  TextEditingController _nameController;

  String _titleString = "";
  String _description = "";
  String _category = "Professional";
  int _cap = 0;
  String _name = "";

  String _dropDownValueCategory = "Professional";

  DateTime start;
  DateTime end;

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: Text(text, style: Theme.of(context).textTheme.headline2),
    );
  }

  void _onSubmit() {
    Map body = {
      "name": _titleController.text,
      "cap": _capController.text,
      "category": _category,
      "description": _descriptionController.text,
    };

    print(body);

    print("submit here");
    createEvent(body, currentUser.getToken());
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _capController = TextEditingController();
    _nameController = TextEditingController();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Padding(
          //   padding: const EdgeInsets.only(top: 20.0),
          //   child: _title("Event title"),
          // ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Your name ?",
            ),
            expands: false,
            minLines: 1,
            maxLines: 1,
            controller: _nameController,
            onEditingComplete: () {
              setState(() {
                _name = _nameController.text;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              hintText: "Title: Tell us what your event is about",
            ),
            expands: false,
            minLines: 1,
            maxLines: 9,
            controller: _titleController,
            onEditingComplete: () {
              setState(() {
                _titleString = _titleController.text;
              });
            },
          ),
         
          TextFormField(
            decoration: InputDecoration(
              hintText:
                  "Description: Tell us who your event is for and what will participants get out of it",
            ),
            expands: false,
            minLines: 1,
            maxLines: 9,
            controller: _descriptionController,
            onEditingComplete: () {
              setState(() {
                _description = _descriptionController.text;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText:
                  "How many people can attend ?",
            ),
            expands: false,
            minLines: 1,
            maxLines: 9,
            keyboardType: TextInputType.number,
            controller: _capController,
            onEditingComplete: () {
              setState(() {
                _cap = int.parse(_capController.text);
              });
            },
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
                    _category = value;
                  });
                })
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: OutlineButton(
              child: Text("Make it live!"),
              onPressed: () => _onSubmit(),
            ),
          ),
        ],
      ),
    );
  }
}
