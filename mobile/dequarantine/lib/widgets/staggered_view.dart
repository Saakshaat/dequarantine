import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Events extends StatefulWidget {
  Events({@required this.events});
  final List events;
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    print(widget.events);
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
        return Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network("https://source.unsplash.com/600x300/?${item["title"]}"),
                ),
                Text(item["title"], style: Theme.of(context).textTheme.headline5,),
                Text(item["description"])
              ],
            ),
          ),
        );
      },
    );
  }
}