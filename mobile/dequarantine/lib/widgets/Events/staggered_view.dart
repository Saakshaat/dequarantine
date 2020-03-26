import 'package:dequarantine/widgets/Events/cards.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Events extends StatefulWidget {
  Events({@required this.events});
  final List events;
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  void _createModalSheet(context, Widget event) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          // color: Colors.red,
          padding: EdgeInsets.all(10),
          child: event,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.events);
    return StaggeredGridView.builder(
      gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
      ),
      itemCount: widget.events.length,
      itemBuilder: (context, index) {
        final item = widget.events[index];
        print("${index.toString()}, ${item["title"]}");
        // double leftPad = 0;
        // double rightPad = 0;
        // double pad = 7;
        // if (index == 0) {
        //   leftPad = pad;
        // } else if (index == 1) {
        //   rightPad = pad;
        // } else {
        //   if (index % 2 == 0) {
        //     rightPad = pad;
        //   } else {
        //     leftPad = pad;
        //   }
        // }
        // DragStartBehavior behavior = DragStartBehavior.();
        return Card(
          elevation: 3,
          child: InkWell(
            onTap: () => _createModalSheet(context,
              DetailedView(
                title: item["title"],
                description: item["description"],
                dateTime: "24.03.2020 - 12:00 PST",
                attendees: 12,
                totalAttendents: 40,
                imageUrl: "https://source.unsplash.com/600x300/?${item["title"]}",
              )
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network("https://source.unsplash.com/600x300/?${item["title"]}"),
                  ),
                  Text(item["title"], style: Theme.of(context).textTheme.headline6,),
                  // Text(item["description"])
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


