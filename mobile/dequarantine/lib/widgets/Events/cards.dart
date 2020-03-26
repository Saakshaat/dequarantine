import 'package:dequarantine/widgets/Events/details.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class DetailedView extends StatefulWidget {
  final imageUrl;
  final title;
  final attendees;
  final totalAttendents;
  final description;
  final dateTime;

  DetailedView({
    @required this.imageUrl,
    @required this.title,
    @required this.attendees,
    @required this.totalAttendents,
    @required this.description,
    @required this.dateTime
  });

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(widget.imageUrl)
          ),
          Details(
            title: widget.title,
            description: widget.description,
            dateTime: widget.dateTime,
            attendees: widget.attendees,
            totalAttendents: widget.totalAttendents,
          )
        ],
      ),
    );
  }
}