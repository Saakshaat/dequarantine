import 'package:dequarantine/UI/widgets/events/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Events extends StatefulWidget {
  Events({@required this.events, @required this.length});
  final List events;
  final int length;
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
    return ListView.builder(
      itemCount: widget.length,
      itemBuilder: (context, index) {
        final item = widget.events[index];

        final String eventId = item["eventId"];
        final String imageUrl = item["imageUrl"];
        final String name = item["name"];
        final String organizer = "test";//item["organizer"].toString();
        final String time = item["time"].toString();
        final String cap = item["cap"].toString();
        final String attending = item["attending"].toString();
        final String category = item["category"];
        final String description = item["description"];

        return Dismissible(
          onDismissed: (direction) {
            //TODO: implement removal
            Scaffold
              .of(context)
              .showSnackBar(SnackBar(
                content: Text("${name.toString()} dismissed"),
                duration: Duration(milliseconds: 500),
              ));
          },
          
          key: Key(eventId.toString()),

          child: Card(
            elevation: 3,
            child: InkWell(
              onTap: () => _createModalSheet(context,
                DetailedView(
                  title: name,
                  description: description,
                  dateTime: DateTime.tryParse(time).toLocal().toString(),
                  attendees: attending.toString(),
                  totalAttendents: cap.toString(),
                  imageUrl: "https://source.unsplash.com/600x300/?${item["category"]}",
                  organizer: organizer,
                  category: category,
                )
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network("https://source.unsplash.com/600x300/?${item["category"]}"),
                    ),
                    Text(name, style: Theme.of(context).textTheme.headline6,),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
    // return StaggeredGridView.builder(
    //   gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 4,
    //     crossAxisSpacing: 8,
    //     mainAxisSpacing: 8,
    //     staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
    //   ),
    //   itemCount: widget.length,
    //   itemBuilder: (context, index) {
    //     final item = widget.events[index];

    //     final String eventId = item["eventId"];
    //     final String imageUrl = item["imageUrl"];
    //     final String name = item["name"];
    //     final String organizer = "test";//item["organizer"].toString();
    //     final String time = item["time"].toString();
    //     final String cap = item["cap"].toString();
    //     final String attending = item["attending"].toString();
    //     final String category = item["category"];
    //     final String description = item["description"];

    //     return Dismissible(
    //       onDismissed: (direction) {
    //         //TODO: implement removal
    //         Scaffold
    //           .of(context)
    //           .showSnackBar(SnackBar(content: Text("${name.toString()} dismissed")));
    //       },
          
    //       key: Key(eventId.toString()),

    //       child: Card(
    //         elevation: 3,
    //         child: InkWell(
    //           onTap: () => _createModalSheet(context,
    //             DetailedView(
    //               title: name,
    //               description: description,
    //               dateTime: DateTime.tryParse(time).toLocal().toString(),
    //               attendees: attending.toString(),
    //               totalAttendents: cap.toString(),
    //               imageUrl: "https://source.unsplash.com/600x300/?${item["category"]}",
    //               organizer: organizer,
    //               category: category,
    //             )
    //           ),
    //           child: Container(
    //             padding: EdgeInsets.all(8),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 ClipRRect(
    //                   borderRadius: BorderRadius.circular(5),
    //                   child: Image.network("https://source.unsplash.com/300x100/?${item["category"]}"),
    //                 ),
    //                 Text(name, style: Theme.of(context).textTheme.headline6,),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}


