import 'package:flutter/material.dart';


class CategoryPage extends StatefulWidget {
  final String title;
  final List widgets;

  CategoryPage({
    this.title,
    this.widgets
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  
  @override
  Widget build(BuildContext context) {
    List<Widget> events = [
      Text("Happening in ${widget.title}", style: TextStyle(fontSize: 25),)
    ];
    widget.widgets.forEach((element) {
      events.add(Card(
        child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                  "https://source.unsplash.com/600x300/?${element["category"]}"),
            ),
            Text(
              element["name"],
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.widgets.length ~/ 2
        ),
        scrollDirection: Axis.horizontal,
        children: events
      ),
    );
  }
}