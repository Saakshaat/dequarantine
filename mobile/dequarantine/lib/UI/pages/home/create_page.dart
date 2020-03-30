import 'package:dequarantine/logic/functions/create_event_functions.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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
      "organizer": _nameController.text,
      "description": _descriptionController.text,
      "imageUrl": "https://aatc-bkk.com/wp-content/uploads/2015/01/tempimage.png",
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
