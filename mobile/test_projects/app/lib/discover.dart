import 'package:app/details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  
  Color category(int index) {
    Color background;
    switch (index) {
      case 1:
        background = Colors.yellow[300];
        break;
      case 2:
        background = Colors.green[300];
        break;
      case 3:
        background = Colors.red[300];
        break;
      case 4:
        background = Colors.blue[300];
        break;
    }

    return background;
  }

  List images = [];

  Widget events(String name, int index) {
    double radius = 10.0;
    return Card(
      elevation: 7,
      // borderRadius: BorderRadius.circular(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      color: category(images[index][1]),
      child: GestureDetector(
        onTap: () => Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(todo: todos[index]),
          )
        ),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(
            //   width: 2,
            //   color: Colors.black54
            // ),
            // borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Image.asset("assets/${images[index][0]}", fit: BoxFit.contain,)
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("event $name as well as sample text\nidk what else to write in here i'm just testing"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    images = data.getDiscover();
    return StaggeredGridView.builder(
      gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        staggeredTileBuilder: (int i) => StaggeredTile.fit(2)
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final item = images[index][0];
        return Dismissible(
          // background: Container(color: backgroundSwipe),
          key: Key(item),
          onDismissed: (direction) {
            String message = "$item dismissed";
            switch (direction) {
              case DismissDirection.startToEnd:
                print("liked");
                data.addLiked(images[index]);
                message = "$item added to liked events";
                break;
              default:
            }

            setState(() {
              data.removeDiscover(index);
            });

            Scaffold.of(context)
                .showSnackBar(SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.black87
                ));
          },
          child: events(item.toString(), index)
        );
      },
    );
  }
}