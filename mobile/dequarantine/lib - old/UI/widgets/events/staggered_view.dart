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
    return StaggeredGridView.builder(
      gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2),
      ),
      itemCount: widget.length,
      itemBuilder: (context, index) {
        final item = widget.events[index];

        return Dismissible(
          onDismissed: (direction) {
            // Remove the item from the data source.
            // setState(() {
            //   widget.events.removeAt(index);
            // });

            // Show a snackbar. This snackbar could also contain "Undo" actions.
            Scaffold
                .of(context)
                .showSnackBar(SnackBar(content: Text("$item dismissed")));
          },
          key: Key(item.toString()),
          child: Card(
            elevation: 3,
            child: InkWell(
              onTap: () => _createModalSheet(context,
                DetailedView(
                  title: item["title"],
                  description: item["description"],
                  dateTime: item["time"],
                  attendees: item["cap"],
                  totalAttendents: item["cap"],
                  imageUrl: "https://source.unsplash.com/600x300/?${item["category"]}",
                  organizer: item["organizer"],
                  category: item["category"],
                )
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network("https://source.unsplash.com/300x100/?${item["category"]}"),
                    ),
                    Text(item["title"], style: Theme.of(context).textTheme.headline6,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


