import 'package:dequarantine/UI/widgets/events/details.dart';
import 'package:flutter/material.dart';


class DetailedView extends StatefulWidget {
  final imageUrl;
  final title;
  final attendees;
  final totalAttendents;
  final description;
  final DateTime dateTime;
  final organizer;
  final category;
  final id;

  DetailedView({
    @required this.imageUrl,
    @required this.title,
    @required this.attendees,
    @required this.totalAttendents,
    @required this.description,
    @required this.dateTime,
    @required this.organizer,
    @required this.category,
    @required this.id,
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 3,
            color: Colors.white
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(widget.imageUrl)
            ),
            Details(
              eventId: widget.id,
              title: widget.title,
              description: widget.description,
              dateTime: widget.dateTime,
              attendees: widget.attendees,
              totalAttendents: widget.totalAttendents,
            )
          ],
        ),
      ),
    );
  }
}