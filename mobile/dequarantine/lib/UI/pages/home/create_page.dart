import 'package:dequarantine/UI/widgets/general/date_time_picker.dart';
import 'package:dequarantine/logic/functions/user/create_event_functions.dart';
import 'package:dequarantine/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  DateTime _startDate;
  TimeOfDay _startTime;

  DateTime _endDate;
  TimeOfDay _endTime;

  String _startDateButton = "Start";
  String _startTimeButton = "";

  String _endDateButton = "End";
  String _endTimeButton = "";

  void _selectStart(DateTime date, TimeOfDay time) {
    String dateString = "${date.year}, ${date.month}, ${date.day}";
    String timeString = "${time.hour} : ${time.minute}";
    setState(() {
      _startDateButton = dateString;
      _startTimeButton = timeString;
    });
  }

  void _selectEnd(DateTime date, TimeOfDay time) {
    String dateString = "${date.year}, ${date.month}, ${date.day}";
    String timeString = "${time.hour} : ${time.minute}";
    setState(() {
      _endDateButton = dateString;
      _endTimeButton = timeString;
    });
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      child: Text(text, style: Theme.of(context).textTheme.headline2),
    );
  }

  void _onSubmit() async {
    Focus.of(context).unfocus();

    DateTime time = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _startTime.hour,
      _startTime.minute
    ).toUtc();

    Map body = {
      "name": _titleController.text,
      "cap": _capController.text,
      "category": _category,
      "organizer": _nameController.text,
      "description": _descriptionController.text,
      "imageUrl":
          "https://aatc-bkk.com/wp-content/uploads/2015/01/tempimage.png",
      "time": time
    };

    print(body);

    print("Passed to function");
    bool passed = await createEvent(body, currentUser.getToken());

    if (passed) {
      Focus.of(context).unfocus();
      Fluttertoast.showToast(msg: "Event created");
      _deleteFields();
    } else {
      Fluttertoast.showToast(msg: "Something failed");
    }
  }

  void _deleteFields() {
    setState(() {
      _titleController.text = "";
      _descriptionController.text = "";
      _capController.text = "";
      _nameController.text = "";
    });
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              OutlineButton(
                onPressed: () async {
                  DateTime tempDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020, 01, 20),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          child: child,
                          data: Theme.of(context),
                        );
                      });

                  TimeOfDay tempTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  setState(() {
                    _startDate = tempDate;
                    _startTime = tempTime;
                  });

                  _selectStart(_startDate, _startTime);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_startDateButton),
                    Text(_startTimeButton)
                  ],
                ),
              ),
              Text("to"),
              OutlineButton(
                onPressed: () async {
                  DateTime tempDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020, 01, 20),
                      lastDate: DateTime(2100),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          child: child,
                          data: Theme.of(context),
                        );
                      });

                  TimeOfDay tempTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  setState(() {
                    _endDate = tempDate;
                    _endTime = tempTime;
                  });

                  _selectEnd(_endDate, _endTime);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_endDateButton),
                    Text(_endTimeButton)
                  ],
                ),
              ),
            ],
          ),

          TextFormField(
            decoration: InputDecoration(
              hintText: "How many people can attend ?",
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
                      value: "Fitness",
                      child: Text("Fitness"),
                    ),
                    DropdownMenuItem(
                      value: "Educational",
                      child: Text("Educational"),
                    ),
                    DropdownMenuItem(
                      value: "Casual",
                      child: Text("Casual"),
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
